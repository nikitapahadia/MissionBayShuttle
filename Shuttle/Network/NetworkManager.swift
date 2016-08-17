//
//  NetworkManager.swift
//  Shuttle
//
//  Created by Nikita Pahadia on 8/17/16.
//  Copyright © 2016 Nikita Pahadia. All rights reserved.
//

import Foundation

enum MyError: ErrorType {
	case WrongAgency
}

class NetworkManager {
	static let sharedInstance = NetworkManager()
	
	let baseURL = "http://api.transitime.org/api/v1/key/5ec0de94/agency/missionBay/command/"
	
	let queue = NSOperationQueue()
	
	func getRoutes() {
		let url = baseURL + "routes"
		
		queue.addOperationWithBlock {
			
				let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
				
				let dataTask = defaultSession.dataTaskWithURL(NSURL(string: url)!) {
					data, response, error in
					print(error)
					print(response)
					print(data)
					let datastring = NSString(data: data!, encoding: NSUTF8StringEncoding)
					print(datastring)
					
					let parser = RouteParser(data: data!)
					parser.parseMe()
				}
				
				dataTask.resume()
		}
	}
}