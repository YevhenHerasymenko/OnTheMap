//
//  PinTabBarController.swift
//  OnTheMap
//
//  Created by Yevhen Herasymenko on 21/11/2015.
//  Copyright © 2015 YevhenHerasymenko. All rights reserved.
//

import UIKit

class PinTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ParseManager.sharedInstance.loadStudentLocations()
    }
    
    //MARK: - Actions

    @IBAction func logout(sender: UIBarButtonItem) {
        SessionManager.sharedInstance.logout()
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func pinPosition(sender: UIBarButtonItem) {
        
    }
    @IBAction func refreshPins(sender: UIBarButtonItem) {
    }
}
