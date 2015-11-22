//
//  ListViewController.swift
//  OnTheMap
//
//  Created by Yevhen Herasymenko on 21/11/2015.
//  Copyright © 2015 YevhenHerasymenko. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, TabBarPinProtocol, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - TabBar
    
    func update() {
        if tableView != nil {
            tableView.reloadData()
        }
    }

    //MARK: - TableVIew
    
    //MARK: DataSource
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        let user: User = ParseManager.sharedInstance.users[indexPath.row]
        
        cell.imageView?.image = UIImage(named: "pin")
        cell.textLabel?.text = "\(user.firstName) \(user.lastName)"
        cell.detailTextLabel?.text = user.mediaUrl
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ParseManager.sharedInstance.users.count
    }
    
    //MARK: Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let user: User = ParseManager.sharedInstance.users[indexPath.row]
        let app = UIApplication.sharedApplication()
        app.openURL(NSURL(string: user.mediaUrl)!)
    }
}
