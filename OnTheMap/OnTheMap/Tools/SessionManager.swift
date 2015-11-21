//
//  SessionManager.swift
//  OnTheMap
//
//  Created by Yevhen Herasymenko on 21/11/2015.
//  Copyright © 2015 YevhenHerasymenko. All rights reserved.
//

import UIKit

typealias loginServerResult = (String) -> ()

class SessionManager: NSObject {
    
    static let sharedInstance = SessionManager()
    
    var sessionToken: String!
    
    func login(email: String, password: String, result: loginServerResult) {
        loginRequest(loginHttpBody(email, password: password), result: result)
    }
    
    func login(facebookToken: String, result: loginServerResult) {
        loginRequest(loginHttpBody(facebookToken), result:  result)
    }
    
    func loginRequest(httpBody: String, result: loginServerResult) {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = httpBody.dataUsingEncoding(NSUTF8StringEncoding)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil {
                result(error!.description)
                return
            }
            let newData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5))
            
            do {
                let responseDictionary = try NSJSONSerialization.JSONObjectWithData(newData, options: []) as! NSDictionary
                self.sessionToken = responseDictionary["session"]!["id"]! as! String
                result("")
            } catch let error as NSError {
                result(error.description)
            }
        }
        task.resume()
    }
    
    func loginHttpBody(email: String, password: String) -> String {
        return "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}"
    }
    
    func loginHttpBody(facebookToken: String) -> String {
        return "{\"facebook_mobile\": {\"access_token\": \"\(facebookToken)\"}}"
    }
}
