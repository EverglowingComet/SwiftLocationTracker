//
//  FirstViewController.swift
//  LocationTracking
//
//  Created by Com on 07/01/2017.
//  Copyright © 2017 Com. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
	
	@IBOutlet weak var lblLocation: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		(self.parent as! TabViewController).viewModel.showLocation = { [weak self] in return self?.showLocation }()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func showLocation(_ address: String) {
		lblLocation.text = address
	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
