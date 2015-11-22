//
//  MyUrlViewController.swift
//  OnTheMap
//
//  Created by Yevhen Herasymenko on 22/11/2015.
//  Copyright © 2015 YevhenHerasymenko. All rights reserved.
//

import UIKit
import MapKit

class MyUrlViewController: UIViewController {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textView: UITextView!
    
    var textViewDelegate: MapTextViewDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.masksToBounds = true
        submitButton.layer.cornerRadius = CGRectGetHeight(submitButton.frame)/4
        textViewDelegate = MapTextViewDelegate(placeholder: textView.text)
        textView.delegate = textViewDelegate
    }
    
    //MARK: - Actions
    
    @IBAction func cancel(sender: UIButton) {
        navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func submit(sender: UIButton) {
        navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func endEdit(sender: AnyObject) {
        view.endEditing(true)
    }
    
}
