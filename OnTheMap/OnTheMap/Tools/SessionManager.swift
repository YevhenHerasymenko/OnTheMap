//
//  SessionManager.swift
//  OnTheMap
//
//  Created by Yevhen Herasymenko on 21/11/2015.
//  Copyright © 2015 YevhenHerasymenko. All rights reserved.
//

import UIKit

class SessionManager: NSObject {
    static let sharedInstance = SessionManager()
    
    func login(email: String, password: String) {
        loginRequest(loginHttpBody(email, password: password))
    }
    
    func login(facebookToken: String) {
        loginRequest(loginHttpBody(facebookToken))
    }
    
    func loginRequest(httpBody: String) {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = httpBody.dataUsingEncoding(NSUTF8StringEncoding)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil {
                // Handle error...
                return
            }
            let newData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5)) /* subset response data! */
            print(NSString(data: newData, encoding: NSUTF8StringEncoding))
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
