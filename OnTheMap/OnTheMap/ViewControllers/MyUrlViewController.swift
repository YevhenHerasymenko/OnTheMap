//
//  MyUrlViewController.swift
//  OnTheMap
//
//  Created by Yevhen Herasymenko on 22/11/2015.
//  Copyright © 2015 YevhenHerasymenko. All rights reserved.
//

import UIKit

class MyUrlViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions
    
    @IBAction func cancel(sender: UIButton) {
        navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }

}
