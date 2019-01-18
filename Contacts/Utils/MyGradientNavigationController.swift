//
//  MyNavigationController.swift
//  Contacts
//
//  Created by Waleed Saad on 1/18/19.
//  Copyright © 2019 Waleed Saad. All rights reserved.
//

import UIKit

class MyGradientNavigationController: UINavigationController {
    
    @IBInspectable var startColor: UIColor = UIColor.yellow {
        didSet {
            self.navigationBar.setNeedsLayout()
        }
    }
//    @IBInspectable var middleColor: UIColor = UIColor.blue {
//        didSet {
//            self.navigationBar.setNeedsLayout()
//        }
//    }
    @IBInspectable var endColor: UIColor = UIColor.purple {
        didSet {
            self.navigationBar.setNeedsLayout()
        }
    }
    
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            self.navigationBar.setNeedsLayout()
        }
    }
    
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 1, y: 0) {
        didSet {
            self.navigationBar.setNeedsLayout()
        }
    }

    let gradient = CAGradientLayer()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var bounds = navigationBar.bounds
        gradient.frame = bounds
        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        
        if let image = getImageFrom(gradientLayer: gradient) {
            //            For small bars
            //            navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
            //            For large bars
            navigationBar.barTintColor = UIColor(patternImage: image)
            
        }
        
    }
    
    
    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }

}
