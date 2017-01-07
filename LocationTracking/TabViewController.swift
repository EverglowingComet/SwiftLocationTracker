//
//  TabViewController.swift
//  LocationTracking
//
//  Created by Com on 07/01/2017.
//  Copyright © 2017 Com. All rights reserved.
//

import UIKit
import BRYXBanner

class TabViewController: UITabBarController {
	
	var viewModel = TabViewModel()
	

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		viewModel.showBanner = showBanner
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func showBanner() {
		let banner = Banner(title: "Alert", subtitle: "You have moved more than 50m.", backgroundColor: .green)
		banner.show(view?.window, duration: 2.0)
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
