//
//  PinTabBarController.swift
//  OnTheMap
//
//  Created by Yevhen Herasymenko on 21/11/2015.
//  Copyright © 2015 YevhenHerasymenko. All rights reserved.
//

import UIKit

@objc protocol TabBarPinProtocol {
    func update()
}

class PinTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsersData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        ParseManager.sharedInstance.findUserLocation()
    }
    
    func loadUsersData() {
        ParseManager.sharedInstance.loadStudentLocations({ () -> () in
            self.update()
            }) { (error) -> () in
                let alertController = UIAlertController(title: error, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                let alertOkAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
                alertController.addAction(alertOkAction)
                self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func update() {
        for viewController in viewControllers! {
            if let protocolObject: TabBarPinProtocol! = viewController as! TabBarPinProtocol {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    protocolObject.update()
                })
            }
        }
    }
    
    //MARK: - Actions

    @IBAction func logout(sender: UIBarButtonItem) {
        SessionManager.sharedInstance.logout()
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func pinPosition(sender: UIBarButtonItem) {
        if ParseManager.sharedInstance.isPostedLocation {
            let message = "User \"\(ParseManager.sharedInstance.user.firstName) \(ParseManager.sharedInstance.user.lastName)\" Has Already Posted a Student Location. Would You Like to Overwrite Their Location?"
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            let alertCancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(alertCancelAction)
            let alertOverwriteAction = UIAlertAction(title: "Overwrite", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                self.performSegueWithIdentifier(SegueConstants.setLocationSegue, sender: self)
            })
            alertController.addAction(alertOverwriteAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            performSegueWithIdentifier(SegueConstants.setLocationSegue, sender: self)
        }
    }
    
    @IBAction func refreshPins(sender: UIBarButtonItem) {
        (viewControllers![0] as! MapViewController).startUpdate()
        loadUsersData()
    }
}
