//
//  MyLocationViewController.swift
//  OnTheMap
//
//  Created by Yevhen Herasymenko on 21/11/2015.
//  Copyright © 2015 YevhenHerasymenko. All rights reserved.
//

import UIKit

class MyLocationViewController: UIViewController {

    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    var textViewDelegate: MapTextViewDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findButton.layer.masksToBounds = true
        findButton.layer.cornerRadius = CGRectGetHeight(findButton.frame)/4
        textViewDelegate = MapTextViewDelegate(placeholder: textView.text)
        textView.delegate = textViewDelegate
    }
    
    //MARK: - Actions

    @IBAction func cancel(sender: UIButton) {
        navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func findOnMap(sender: UIButton) {
        self.performSegueWithIdentifier("setMyUrlSegue", sender: self)
    }
    
    @IBAction func endEdit(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

}
