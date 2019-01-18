//
//  ViewController.swift
//  Contacts
//
//  Created by Waleed Saad on 1/17/19.
//  Copyright © 2019 Waleed Saad. All rights reserved.
//

import UIKit

class ContactsVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearSearchbarBackground()
        
    }

    private func clearSearchbarBackground(){
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundImage = UIImage()
        let searchTextField = searchBar.value(forKey: "searchField") as? UITextField
        searchTextField?.textColor = UIColor.purple
        searchTextField?.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        searchTextField?.attributedPlaceholder =  NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(1.0)])
        searchBar.setImage(UIImage(named: "icon_search"), for: UISearchBar.Icon.search, state: .normal)

    }

}

