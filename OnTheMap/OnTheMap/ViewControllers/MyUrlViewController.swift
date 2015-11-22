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
    var placemark: MKPlacemark!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.masksToBounds = true
        submitButton.layer.cornerRadius = CGRectGetHeight(submitButton.frame)/4
        textViewDelegate = MapTextViewDelegate(placeholder: textView.text)
        textView.delegate = textViewDelegate
        
        var region = self.mapView.region
        let placemarkRegion: CLCircularRegion = placemark.region as! CLCircularRegion
        ParseManager.sharedInstance.user.latitude = placemark.coordinate.latitude
        ParseManager.sharedInstance.user.longitude = placemark.coordinate.longitude
        region.center = placemarkRegion.center
        region.span.latitudeDelta /= 8.0
        region.span.longitudeDelta /= 8.0
        
        mapView.setRegion(region, animated: false)
        mapView.addAnnotation(placemark)
    }
    
    //MARK: - Actions
    
    @IBAction func cancel(sender: UIButton) {
        navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func submit(sender: UIButton) {
        ParseManager.sharedInstance.user.mediaUrl = self.textView.text
        ParseManager.sharedInstance.setUserLocation()
        navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func endEdit(sender: AnyObject) {
        view.endEditing(true)
    }
    
}
