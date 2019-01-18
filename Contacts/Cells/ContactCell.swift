//
//  ContactCell.swift
//  Contacts
//
//  Created by Waleed Saad on 1/18/19.
//  Copyright © 2019 Waleed Saad. All rights reserved.
//

import UIKit
import SwipeCellKit

class ContactCell: SwipeTableViewCell {

    private var contactView: ContactXibView?
    var contactsVC: ContactsVC?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    
    private func setupView(){
        contactView = Bundle.main.loadNibNamed("ContactXib", owner: self, options: nil)?.first as? ContactXibView
        contactView?.frame = self.frame
        contactView?.favoritebutton.addTarget(self, action: #selector(handleFav), for: .touchUpInside)
        if contactView != nil {
            self.addSubview(contactView!)
        }
    }
    
    func updateViews(contact: Contact){
        contactView?.nameLabel.text = contact.name
        contactView?.phoneLabel.text = contact.phone
    }
   
    @objc private func handleFav() {
        contactsVC?.handleFav(cell: self)
    }
}
