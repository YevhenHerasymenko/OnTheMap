//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Yevhen Herasymenko on 11/18/15.
//  Copyright © 2015 YevhenHerasymenko. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func endEditing(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
