//
//  MyGradientView.swift
//  Contacts
//
//  Created by Waleed Saad on 1/18/19.
//  Copyright © 2019 Waleed Saad. All rights reserved.
//

import UIKit

class MyGradientView: UIView {
    
    @IBInspectable var startColor: UIColor = UIColor.yellow {
        didSet {
            self.setNeedsLayout()
        }
    }
    //    @IBInspectable var middleColor: UIColor = UIColor.blue {
    //        didSet {
    //            self.navigationBar.setNeedsLayout()
    //        }
    //    }
    @IBInspectable var endColor: UIColor = UIColor.purple {
        didSet {
            self.setNeedsLayout()
        }
    }

    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            self.setNeedsLayout()
        }
    }

    @IBInspectable var endPoint: CGPoint = CGPoint(x: 1, y: 0) {
        didSet {
            self.setNeedsLayout()
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable var shadowColor: UIColor = UIColor.gray {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    let gradientLayer = CAGradientLayer()

        override func layoutSubviews() {
            super.layoutSubviews()
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            gradientLayer.startPoint = startPoint
            gradientLayer.endPoint = endPoint
            layer.cornerRadius = cornerRadius
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = shadowOffset
            layer.shadowRadius = shadowRadius
            layer.shadowOpacity = shadowOpacity
            gradientLayer.frame = bounds
            layer.insertSublayer(gradientLayer, at: 0)
        }

}
