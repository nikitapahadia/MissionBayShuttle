//
//  FirstViewController.swift
//  Shuttle
//
//  Created by Nikita Pahadia on 7/20/16.
//  Copyright © 2016 Nikita Pahadia. All rights reserved.
//

import UIKit

import RealmSwift

extension UIColor {
	convenience init(red: Int, green: Int, blue: Int) {
		assert(red >= 0 && red <= 255, "Invalid red component")
		assert(green >= 0 && green <= 255, "Invalid green component")
		assert(blue >= 0 && blue <= 255, "Invalid blue component")
		
		self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
	}
	
	convenience init(netHex:Int) {
		self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
	}
	
	convenience init(hexString: String) {
		let nextString = hexString.stringByReplacingOccurrencesOfString("#", withString: "")
		
		let netHex = Int(nextString, radix: 16)//Int( UInt8(strtoul(nextString, nil, 16)))
		
		self.init(red:(netHex! >> 16) & 0xff, green:(netHex! >> 8) & 0xff, blue:netHex! & 0xff)
	}
}


class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	var routeList: Results<Route>?
	
	
	@IBOutlet weak var tableView: UITableView!
	override func viewDidLoad() {
		super.viewDidLoad()
		
		print(Realm.Configuration.defaultConfiguration.fileURL!)
		
		let network = NetworkManager.sharedInstance
		dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
			network.getRoutes() { [weak self] in
				self?.updateUI()
			}
		}
	}
	
	func updateUI() {
		
		let uiRealm = try! Realm()
		self.routeList = uiRealm.objects(Route)
		tableView.reloadData()
	}
	
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if routeList == nil {
			return 0
		}
		return routeList!.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("RouteCell") as? RouteTableViewCell
		
		let route = routeList![indexPath.row]
		
		cell?.mainLabel.text = route.routeID
		cell?.detailLabel.text = route.name
		if let textColor = route.textColor {
			cell?.detailLabel.textColor = UIColor(hexString: textColor)
		}
		//		cell?.backgroundColor = route.color
		
		return cell!
	}
}

