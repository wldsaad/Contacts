//
//  ContactCell.swift
//  Contacts
//
//  Created by Waleed Saad on 1/18/19.
//  Copyright © 2019 Waleed Saad. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    private var contactView: ContactXibView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    private func setupView(){
        contactView = Bundle.main.loadNibNamed("ContactXib", owner: self, options: nil)?.first as? ContactXibView
        contactView?.frame = self.frame
        if contactView != nil {
            self.insertSubview(contactView!, at: 0)
        }
    }
   
}
