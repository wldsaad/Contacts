//
//  MyRoundedView.swift
//  Contacts
//
//  Created by Waleed Saad on 1/19/19.
//  Copyright © 2019 Waleed Saad. All rights reserved.
//

import UIKit
import ChameleonFramework

@IBDesignable
class MyFavouriteRoundedView: UIView {

    @IBOutlet weak var favNameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.size.width / 2
        backgroundColor = RandomFlatColor()
        favNameLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn: backgroundColor!, isFlat: true)
    }
}
