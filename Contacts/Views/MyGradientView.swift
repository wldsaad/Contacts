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

    let gradient = CAGradientLayer()

        override func layoutSubviews() {
            super.layoutSubviews()
            gradient.frame = bounds
            gradient.colors = [startColor.cgColor, endColor.cgColor]
            gradient.startPoint = startPoint
            gradient.endPoint = endPoint
            layer.insertSublayer(gradient, at: 0)
        }

}
