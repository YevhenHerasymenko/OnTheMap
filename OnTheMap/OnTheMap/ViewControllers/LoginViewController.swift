//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Yevhen Herasymenko on 11/18/15.
//  Copyright © 2015 YevhenHerasymenko. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func endEditing(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func login(sender: UIButton) {
        
    }
    
    @IBAction func loginWithFacebook(sender: UIButton) {
        
    }
    
    @IBAction func signUp(sender: UIButton) {
        let safariVC = SFSafariViewController(URL: NSURL(string: "https://udacity.com/account/auth#!/signup")!)
        self.presentViewController(safariVC, animated: true, completion: nil)
    }
}
