//
//  FirstViewController.swift
//  Shuttle
//
//  Created by Nikita Pahadia on 7/20/16.
//  Copyright © 2016 Nikita Pahadia. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		let network = NetworkManager.sharedInstance
		network.getRoutes()
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

