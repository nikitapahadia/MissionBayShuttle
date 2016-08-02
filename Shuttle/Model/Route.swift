//
//  Route.swift
//  Shuttle
//
//  Created by Nikita Pahadia on 7/21/16.
//  Copyright © 2016 Nikita Pahadia. All rights reserved.
//

import Foundation
import RealmSwift

class Route: Object {
	
	dynamic var id = ""
	dynamic var name = ""
	dynamic var color = ""
	dynamic var textColor = ""
	dynamic var type = ""
	// Specify properties to ignore (Realm won't persist these)
	
	//  override static func ignoredProperties() -> [String] {
	//    return []
	//  }
}
