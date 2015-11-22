//
//  ListViewController.swift
//  OnTheMap
//
//  Created by Yevhen Herasymenko on 21/11/2015.
//  Copyright © 2015 YevhenHerasymenko. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, TabBarPinProtocol {
    
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

}
