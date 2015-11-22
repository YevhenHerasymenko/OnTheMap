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

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    //MARK: - Actions

    @IBAction func endEditing(sender: UITapGestureRecognizer!) {
        view.endEditing(true)
    }
    @IBAction func login(sender: UIButton) {
        endEditing(nil)
        sender.enabled = false
        
        if emailTextField.text?.characters.count == 0 || passwordTextField.text?.characters.count == 0 {
            showAlert("Email or password cannot be nil")
        } else {
            SessionManager.sharedInstance.login(emailTextField.text!, password: passwordTextField.text!, result: { (error) -> () in
                sender.enabled = true
                self.loginNavigation(error)
            })
        }
    }
    
    @IBAction func loginWithFacebook(sender: UIButton) {
        let login: FBSDKLoginManager = FBSDKLoginManager()
        login.logInWithReadPermissions(["public_profile"], fromViewController: self) { (result, error) -> Void in
            if (error != nil) {
                self.showAlert(error.description)
            } else if result.isCancelled {
                print("Was cancelled")
            } else {
                SessionManager.sharedInstance.login(result.token.tokenString, result: { (errorRequest) -> () in
                    self.loginNavigation(errorRequest)
                })
            }
        }
    }
    
    @IBAction func signUp(sender: UIButton) {
        let safariVC = SFSafariViewController(URL: NSURL(string: "https://udacity.com/account/auth#!/signup")!)
        self.presentViewController(safariVC, animated: true, completion: nil)
    }
    
    //MARK: - Navigation
    
    func loginNavigation(error: String!) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            if (error.characters.count != 0) {
                self.showAlert(error)
            } else {
                self.performSegueWithIdentifier(SegueConstants.loginSegue, sender: self)
            }
        }
    }
    
    //MARK: - Alert
    
    func showAlert(title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        let alertOkAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        alertController.addAction(alertOkAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Text Field Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
