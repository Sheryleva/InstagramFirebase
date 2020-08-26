//
//  Round.swift
//  Calculator1
//
//  Created by Sheryl Evangelene Pulikandala on 7/8/20.
//  Copyright © 2020 Sheryl Evangelene Pulikandala. All rights reserved.
//

import UIKit

@IBDesignable
class Round: UIImageView {
    
    
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}




