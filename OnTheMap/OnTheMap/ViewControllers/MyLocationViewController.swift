//
//  MyLocationViewController.swift
//  OnTheMap
//
//  Created by Yevhen Herasymenko on 21/11/2015.
//  Copyright © 2015 YevhenHerasymenko. All rights reserved.
//

import UIKit
import MapKit

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
        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.geocodeAddressString(textView.text) { (placemarks, error) -> Void in
            if (error != nil || placemarks?.count == 0) {
                let alertController = UIAlertController(title: nil, message: "Could Not Geocode the String", preferredStyle: UIAlertControllerStyle.Alert)
                let alertOkAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel, handler: nil)
                alertController.addAction(alertOkAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                
            } else {
                let topResult = placemarks![0]
                let placemark = MKPlacemark(placemark: topResult)
                self.performSegueWithIdentifier(SegueConstants.setMyUrlSegue, sender: placemark)
            }
        }
    }
    
    @IBAction func endEdit(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SegueConstants.setMyUrlSegue {
            let urlController: MyUrlViewController = segue.destinationViewController as! MyUrlViewController
            urlController.placemark = sender as! MKPlacemark
        }
    }

}
