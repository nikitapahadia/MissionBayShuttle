//
//  RouteParser.swift
//  Shuttle
//
//  Created by Nikita Pahadia on 8/17/16.
//  Copyright © 2016 Nikita Pahadia. All rights reserved.
//

import Foundation

import RealmSwift

class RouteParser {
	var data: NSData?
	
	init(data: NSData) {
		self.data = data
	}
	
	func parseMe(completion: ()->Void) {
		do {
		guard let jsonObj = try NSJSONSerialization.JSONObjectWithData(self.data!, options: .AllowFragments) as? NSDictionary else {
			return
		}
			/*
			{"agency":"Mission Bay Shuttle","routes":[{"id":"caltrain","name":"Caltrain - Caltrain","shortName":"Caltrain","longName":"Caltrain","color":"e52e0e","textColor":"ffffff","type":"3"},{"id":"east","name":"East Side Express","shortName":"East Side Express","longName":"East Side Express","color":"0044aa","textColor":"ffffff","type":"3"},{"id":"loop","name":"MB Loop - MB Loop","shortName":"MB Loop","longName":"MB Loop","color":"b27cb2","textColor":"000000","type":"3"},{"id":"transbay","name":"Transbay - Transbay","shortName":"Transbay","longName":"Transbay","color":"664e00","textColor":"ffffff","type":"3"},{"id":"west","name":"West Side Express","shortName":"West Side Express","longName":"West Side Express","color":"44aa00","textColor":"ffffff","type":"3"}]}
*/
			if let agency = jsonObj["agency"] {
				if !agency.isEqual("Mission Bay Shuttle") {
					throw MyError.WrongAgency
				}
			}
			
			guard let routesArray = jsonObj["routes"] as? NSArray else {
				return
			}
			
			let realmObj = try! Realm()
			
			for route in routesArray {
				if let rDict = route as? NSDictionary {
					let r = Route()
					r.routeID = rDict["id"] as! String
					r.name = rDict["name"] as! String
					r.color = rDict["color"] as? String
					r.textColor = rDict["textColor"] as? String
					r.type = rDict["type"] as? String
					
					try realmObj.write {
							realmObj.add(r)
						}
				}
				
			}
			completion()
			
		} catch {
			
		}
		
	}
}