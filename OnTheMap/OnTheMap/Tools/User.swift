//
//  User.swift
//  OnTheMap
//
//  Created by Yevhen Herasymenko on 22/11/2015.
//  Copyright © 2015 YevhenHerasymenko. All rights reserved.
//

import Foundation

struct User {
    var userId: Int!
    var firstName: String!
    var lastName: String!
    var longitude: Double!
    var latitude: Double!
    var mapString: String!
    var mediaUrl: String!
    
    init() { }
    
    init(dictionaty: NSDictionary) {
        mediaUrl = dictionaty[UserKeys.mediaURL] as! String
        mapString = dictionaty[UserKeys.mapString] as! String
        firstName = dictionaty[UserKeys.firstName] as! String
        lastName = dictionaty[UserKeys.lastName] as! String
        longitude = dictionaty[UserKeys.longitude] as! Double
        latitude = dictionaty[UserKeys.latitude] as! Double
    }
}