//
//  PinTabBarController.swift
//  OnTheMap
//
//  Created by Yevhen Herasymenko on 21/11/2015.
//  Copyright © 2015 YevhenHerasymenko. All rights reserved.
//

import UIKit

protocol TabBarPinProtocol {
    func update()
}

class PinTabBarController: UITabBarController {
    
    var users: Array<User>!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsersData()
    }
    
    func loadUsersData() {
        ParseManager.sharedInstance.loadStudentLocations { (users) -> () in
            self.users = users
            
            for viewController in self.viewControllers! {
                if let protocolObject: TabBarPinProtocol! = viewController as! TabBarPinProtocol {
                    protocolObject.update()
                }
            }
        }
    }
    
    //MARK: - Actions

    @IBAction func logout(sender: UIBarButtonItem) {
        SessionManager.sharedInstance.logout()
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func pinPosition(sender: UIBarButtonItem) {
        performSegueWithIdentifier(SegueConstants.setLocationSegue, sender: self)
    }
    
    @IBAction func refreshPins(sender: UIBarButtonItem) {
        loadUsersData()
    }
}
