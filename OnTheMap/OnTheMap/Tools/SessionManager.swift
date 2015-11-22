//
//  SessionManager.swift
//  OnTheMap
//
//  Created by Yevhen Herasymenko on 21/11/2015.
//  Copyright © 2015 YevhenHerasymenko. All rights reserved.
//

import UIKit

typealias loginServerResult = (String) -> ()

class SessionManager {
    
    static let sharedInstance = SessionManager()
    
    var sessionToken: String!
    var userId: String!
    
    //MARK: - Login
    
    func login(email: String, password: String, result: loginServerResult) {
        loginRequest(loginHttpBody(email, password: password), result: result)
    }
    
    func login(facebookToken: String, result: loginServerResult) {
        loginRequest(loginHttpBody(facebookToken), result:  result)
    }
    
    func loginRequest(httpBody: String, result: loginServerResult) {
        let request = NSMutableURLRequest(URL: NSURL(string: UrlConstants.sessionUrl)!)
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
                self.userId = responseDictionary["account"]!["key"]! as! String
                result("")
                self.getUserDataRequest()
            } catch let error as NSError {
                result(error.description)
            }
        }
        task.resume()
    }
    
    //MARK: Login Body
    
    func loginHttpBody(email: String, password: String) -> String {
        return "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}"
    }
    
    func loginHttpBody(facebookToken: String) -> String {
        return "{\"facebook_mobile\": {\"access_token\": \"\(facebookToken)\"}}"
    }
    
    //MARK: - User Data
    
    func getUserDataRequest() {
        let request = NSMutableURLRequest(URL: NSURL(string: UrlConstants.usersUrl + userId)!)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error...
                return
            }
            let newData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5)) /* subset response data! */
            
            do {
                let responseDictionary = try NSJSONSerialization.JSONObjectWithData(newData, options: []) as! NSDictionary
                print(responseDictionary)
                
            } catch _ as NSError { }
        }
        task.resume()
    }
    
    //MARK: - Logout
    
    func logout() {
        let request = NSMutableURLRequest(URL: NSURL(string: UrlConstants.sessionUrl)!)
        request.HTTPMethod = "DELETE"
        var xsrfCookie: NSHTTPCookie? = nil
        let sharedCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in sharedCookieStorage.cookies! as [NSHTTPCookie] {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let newData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5)) /* subset response data! */
            print(NSString(data: newData, encoding: NSUTF8StringEncoding))
        }
        task.resume()
    }
}
