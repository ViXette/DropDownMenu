//
//  Created by ViXette on 27/08/2018.
//

import UIKit


class DropDownButton: UIButton, DropDownDelegate {
	
	var dropDownView = DropDownView()
	
	var height = NSLayoutConstraint()
	
	var isOpen = false
	
	///
	override init (frame: CGRect) {
		super.init(frame: frame)
		
		backgroundColor = UIColor.darkGray
		
		dropDownView = DropDownView.init(frame: .zero)
		
		dropDownView.translatesAutoresizingMaskIntoConstraints = false
		
		dropDownView.delegate = self
	}
	
	///
	override func didMoveToSuperview() {
		superview?.addSubview(dropDownView)
		
		dropDownView.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
		dropDownView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		dropDownView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
		
		height = dropDownView.heightAnchor.constraint(equalToConstant: 0)
	}
	
	///
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		toggleDropDown()
	}
	
	///
	func toggleDropDown () {
		NSLayoutConstraint.deactivate([height])
		
		height.constant = isOpen
			? 0
			: dropDownView.tableView.contentSize.height > 150
			? 150
			: dropDownView.tableView.contentSize.height
		
		NSLayoutConstraint.activate([height])
		
		UIView.animate(
			withDuration: 0.5,
			delay: 0,
			usingSpringWithDamping: 0.5,
			initialSpringVelocity: 0.5,
			options: .curveEaseInOut,
			animations: {
				if !self.isOpen {
					self.dropDownView.layoutIfNeeded()
				}
				
				let height = self.dropDownView.frame.height / 2
				self.dropDownView.center.y += self.isOpen ? -height : height
				
				if self.isOpen {
					self.dropDownView.layoutIfNeeded()
				}
		},
			completion: nil
		)
		
		isOpen = !isOpen
	}
	
	///
	required init? (coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	///
	func dropDownPressed(string: String) {
		titleLabel?.text = string
		
		toggleDropDown()
	}
	
}


// MARK: DropDownView
class DropDownView: UIView, UITableViewDelegate, UITableViewDataSource {
	
	var dropDownOptions: [String] = []
	
	var tableView = UITableView()
	
	var delegate: DropDownDelegate?
	
	///
	override init (frame: CGRect) {
		super.init(frame: frame)
		
		tableView.backgroundColor = UIColor.darkGray
		
		tableView.delegate = self
		tableView.dataSource = self
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		self.addSubview(tableView)
		
		tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
	}
	
	///
	required init? (coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	///
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	///
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dropDownOptions.count
	}
	
	///
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		
		cell.textLabel?.text = dropDownOptions[indexPath.row]
		//cell.backgroundColor = UIColor.darkGray
		
		return cell
	}
	
	///
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		delegate?.dropDownPressed(string: dropDownOptions[indexPath.row])
	}
	
}


// MARK: DropDownDelegate
protocol DropDownDelegate {
	
	///
	func dropDownPressed (string: String)
	
}
