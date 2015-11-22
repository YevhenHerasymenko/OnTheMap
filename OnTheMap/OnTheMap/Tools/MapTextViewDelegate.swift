//
//  MapTextViewDelegate.swift
//  OnTheMap
//
//  Created by Yevhen Herasymenko on 22/11/2015.
//  Copyright © 2015 YevhenHerasymenko. All rights reserved.
//

import UIKit

class MapTextViewDelegate: NSObject, UITextViewDelegate {
    
    var placeholder: String
    
    init(placeholder: String) {
        self.placeholder = placeholder
    }
    
    //MARK - TextView Delegate
    
    func textViewDidBeginEditing(textView: UITextView) {
        textView.textAlignment = NSTextAlignment.Left
        if textView.text == placeholder {
            textView.text = nil
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        textView.textAlignment = NSTextAlignment.Center
        if textView.text.characters.count == 0 {
            textView.text = placeholder
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.canResignFirstResponder()
        }
        return true
    }
    
}
