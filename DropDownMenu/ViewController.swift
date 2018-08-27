//
//  Created by ViXette on 27/08/2018.
//

import UIKit


class ViewController: UIViewController {
	
	var button = DropDownButton()

	///
	override func viewDidLoad () {
		super.viewDidLoad()
		
		button = DropDownButton.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		button.setTitle("Colors", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(button)
		
		button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		
		button.widthAnchor.constraint(equalToConstant: 150).isActive = true
		button.heightAnchor.constraint(equalToConstant: 50).isActive = true
		
		button.dropDownView.dropDownOptions = ["Red", "Green", "Blue", "Yellow"]
	}

}
