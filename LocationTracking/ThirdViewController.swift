//
//  ThirdViewController.swift
//  LocationTracking
//
//  Created by Com on 07/01/2017.
//  Copyright © 2017 Com. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
	
	@IBOutlet weak var tableMoving: UITableView!
	
	var allMoves = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		allMoves = (self.parent as! TabViewController).viewModel.allMoves
		tableMoving.reloadData()
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

extension ThirdViewController : UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return allMoves.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "MovingCell")
		
		var data = allMoves[indexPath.row]
		
		cell?.textLabel?.text = data["date"] as! String?
		cell?.detailTextLabel?.text = String(format: "%f m", (data["distance"] as! Double))
		
		return cell!
	}
}
