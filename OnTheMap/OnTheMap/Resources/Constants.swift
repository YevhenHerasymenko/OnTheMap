//
//  Constants.swift
//  OnTheMap
//
//  Created by Yevhen Herasymenko on 21/11/2015.
//  Copyright © 2015 YevhenHerasymenko. All rights reserved.
//

import Foundation

typealias usersResult = () -> ()
typealias errorResult = (String) -> ()

struct SegueConstants {
    static let loginSegue = "loginSegue"
    static let setLocationSegue = "setLocationSegue"
    static let setMyUrlSegue = "setMyUrlSegue"
}

struct UrlConstants {
    //Udacity
    static let sessionUrl = "https://www.udacity.com/api/session"
    static let usersUrl = "https://www.udacity.com/api/users/"
    //Parse
    static let studentLocation = "https://api.parse.com/1/classes/StudentLocation"
}

struct UserKeys {
    static let firstName = "firstName"
    static let mediaURL = "mediaURL"
    static let longitude = "longitude"
    static let uniqueKey = "uniqueKey"
    static let latitude = "latitude"
    static let objectId = "objectId"
    static let createdAt = "createdAt"
    static let updatedAt = "updatedAt"
    static let mapString = "mapString"
    static let lastName = "lastName"
}