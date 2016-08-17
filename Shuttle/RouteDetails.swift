//
//  RouteDetails.swift
//  Shuttle
//
//  Created by Nikita Pahadia on 8/16/16.
//  Copyright © 2016 Nikita Pahadia. All rights reserved.
//

import Foundation
import RealmSwift

class RouteDetails: Object {
	dynamic var route: Route?
	var shapes = List<Shape>()
	var directions = List<Direction>()
	dynamic var extent: Extent?
	
	
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
