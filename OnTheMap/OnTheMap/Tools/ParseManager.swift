//
//  ParseManager.swift
//  OnTheMap
//
//  Created by Yevhen Herasymenko on 21/11/2015.
//  Copyright © 2015 YevhenHerasymenko. All rights reserved.
//

import Foundation

typealias usersResult = () -> ()

class ParseManager {
    
    static let sharedInstance = ParseManager()

    var user: User!
     var users: Array<User>!
    
    var isPostedLocation: Bool = false
    
    func loadStudentLocations(result: usersResult) {
        let params = ["limit": 100, "order": "-updatedAt"]
        let urlString = UrlConstants.studentLocation + escapedParameters(params)
        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
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
                self.users = Array<User>()
                if let results = responseDictionary["results"] {
                    let usersDictionary: Array<NSDictionary> = results as! Array<NSDictionary>
                    for userDictionary: NSDictionary in usersDictionary {
                        var user: User = User()
                        user.mediaUrl = userDictionary[UserKeys.mediaURL] as! String
                        user.mapString = userDictionary[UserKeys.mapString] as! String
                        user.firstName = userDictionary[UserKeys.firstName] as! String
                        user.lastName = userDictionary[UserKeys.lastName] as! String
                        user.longitude = userDictionary[UserKeys.longitude] as! Double
                        user.latitude = userDictionary[UserKeys.latitude] as! Double
                        self.users.append(user)
                    }
                    result()
                } else if let error = responseDictionary["error"] {
                    print(error)
                }


            } catch let error as NSError {
                print (error.description)
            }
        }
        task.resume()
    }
    
    
    func setUserLocation() {
        var urlString = UrlConstants.studentLocation
        if isPostedLocation {
            urlString += SessionManager.sharedInstance.userId
        }
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = isPostedLocation ? "PUT" : "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"uniqueKey\": \"\(SessionManager.sharedInstance.userId))\", \"firstName\": \"\(user.firstName)\", \"lastName\": \"\(user.lastName)\",\"mapString\": \"\(user.mapString)\", \"mediaURL\": \"\(user.mediaUrl)\",\"latitude\": \(user.latitude), \"longitude\": \(user.longitude)}".dataUsingEncoding(NSUTF8StringEncoding)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil {
                print(error?.description)
                return
            }
        }
        task.resume()
    }
    
    func findUserLocation() {
        let urlString = "https://api.parse.com/1/classes/StudentLocation?where=%7B%22uniqueKey%22%3A%22\(SessionManager.sharedInstance.userId)%22%7D"
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { /* Handle error */ return }
            do {
                let responseDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
                self.isPostedLocation = (responseDictionary["results"] != nil)
            } catch let error as NSError {
                print (error.description)
            }
        }
        task.resume()
    }
    
    //MARK: - Parameters
    
    func escapedParameters(parameters: [String : AnyObject]) -> String {
        var urlVars = [String]()
        for (key, value) in parameters {
            let stringValue = "\(value)"
            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            urlVars += [key + "=" + "\(escapedValue!)"]
        }
        return (!urlVars.isEmpty ? "?" : "") + urlVars.joinWithSeparator("&")
    }
    
}
