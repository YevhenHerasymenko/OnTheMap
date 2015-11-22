//
//  MyLocationViewController.swift
//  OnTheMap
//
//  Created by Yevhen Herasymenko on 21/11/2015.
//  Copyright © 2015 YevhenHerasymenko. All rights reserved.
//

import UIKit

class MyLocationViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var findButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findButton.layer.masksToBounds = true
        findButton.layer.cornerRadius = CGRectGetHeight(findButton.frame)/4
    }
    
    //MARK: - Actions

    @IBAction func cancel(sender: UIButton) {
        navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func findOnMap(sender: UIButton) {
        
    }
    
    //MARK: - Text View Delegate
    
    func textViewDidBeginEditing(textView: UITextView) {
        textView.textAlignment = NSTextAlignment.Left
        if textView.text == StringConstant.locationHere {
            textView.text = nil
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        textView.textAlignment = NSTextAlignment.Center
        if textView.text.characters.count == 0 {
            textView.text = StringConstant.locationHere
        }
    }
    
}
