//
//  ParseManager.swift
//  OnTheMap
//
//  Created by Yevhen Herasymenko on 21/11/2015.
//  Copyright © 2015 YevhenHerasymenko. All rights reserved.
//

import Foundation

typealias usersResult = (Array<User>) -> ()

class ParseManager {
    
    static let sharedInstance = ParseManager()

    var user: User!
    
    func loadStudentLocations(result: usersResult) {
        let request = NSMutableURLRequest(URL: NSURL(string: UrlConstants.studentLocation)!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil {
                print (error?.description)
                return
            }
            do {
                let responseDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
                var users: Array<User> = Array<User>()
                let usersDictionary: Array<NSDictionary> = responseDictionary["results"] as! Array<NSDictionary>
                for userDictionary: NSDictionary in usersDictionary {
                    var user: User = User()
                    user.mediaUrl = userDictionary[UserKeys.mediaURL] as! String
                    user.mapString = userDictionary[UserKeys.mapString] as! String
                    user.firstName = userDictionary[UserKeys.firstName] as! String
                    user.lastName = userDictionary[UserKeys.lastName] as! String
                    user.longitude = userDictionary[UserKeys.longitude] as! Double
                    user.latitude = userDictionary[UserKeys.latitude] as! Double
                    users.append(user)
                }
                result(users)

            } catch let error as NSError {
                print (error.description)
            }
        }
        task.resume()
    }
    
    
    func setUserLocation(update: Bool) {
        let urlString = "https://api.parse.com/1/classes/StudentLocation/8ZExGR5uX8"
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = update ? "PUT" : "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Cupertino, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.322998, \"longitude\": -122.032182}".dataUsingEncoding(NSUTF8StringEncoding)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
        }
        task.resume()
    }
    
}
