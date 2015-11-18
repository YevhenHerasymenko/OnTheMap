//
//  PaddingTextField.swift
//  OnTheMap
//
//  Created by Yevhen Herasymenko on 18/11/2015.
//  Copyright © 2015 YevhenHerasymenko. All rights reserved.
//

import UIKit

class PaddingTextField: UITextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        attributedPlaceholder = NSAttributedString(string:placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 10)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 10)
    }

}
