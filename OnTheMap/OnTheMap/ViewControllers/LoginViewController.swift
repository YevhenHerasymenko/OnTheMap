//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Yevhen Herasymenko on 11/18/15.
//  Copyright © 2015 YevhenHerasymenko. All rights reserved.
//

import UIKit
import SafariServices
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    //MARK: - Actions

    @IBAction func endEditing(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func login(sender: UIButton) {
        
    }
    
    @IBAction func loginWithFacebook(sender: UIButton) {
        let login: FBSDKLoginManager = FBSDKLoginManager()
        login.logInWithReadPermissions(["public_profile"], fromViewController: self) { (result, error) -> Void in
            if (error != nil) {
                
                print(error.description)
            } else if result.isCancelled {
                print("Was cancelled")
            } else {
                SessionRequestManager.sharedInstance.login(result.token.tokenString)
            }
        }
    }
    
    @IBAction func signUp(sender: UIButton) {
        let safariVC = SFSafariViewController(URL: NSURL(string: "https://udacity.com/account/auth#!/signup")!)
        self.presentViewController(safariVC, animated: true, completion: nil)
    }
    
    //MARK: - Alert
    
    func showAlert(title: String) {
        
    }
}
