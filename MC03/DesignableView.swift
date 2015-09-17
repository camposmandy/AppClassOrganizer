//
//  DesignableView.swift
//  boxMovement
//
//  Created by João Marcos on 15/04/15.
//  Copyright (c) 2015 João Marcos. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor {
        get {
            return UIColor(CGColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.CGColor
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var clipping: Bool {
        get {
            return clipsToBounds
        }
        set {
            clipsToBounds = newValue
        }
    }
}

@IBDesignable
class JMImageView: UIImageView {
    @IBInspectable
    var clips: Bool {
        get {
            return self.clipsToBounds
        }
        set {
            self.clipsToBounds = newValue
        }
    }
}

@IBDesignable
class JMButton: UIButton {}

@IBDesignable
class JMLabel: UILabel {}

@IBDesignable
class JMView: UIView {}

@IBDesignable
class JMTextField: UITextField {}

@IBDesignable
class JMTextView: UITextView {}