//
//  FavouriteCell.swift
//  Contacts
//
//  Created by Waleed Saad on 1/19/19.
//  Copyright © 2019 Waleed Saad. All rights reserved.
//

import UIKit

class FavouriteCell: UICollectionViewCell {
    
    private var favView: MyFavouriteRoundedView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView(){
        favView = Bundle.main.loadNibNamed("FavouriteXib", owner: self, options: nil)?.first as? MyFavouriteRoundedView
        favView?.frame = self.frame
        if favView != nil {
            self.addSubview(favView!)
        }
    }
    
    func updateViews(contact: Contact){
        favView?.favNameLabel.text = contact.name
    }
}
