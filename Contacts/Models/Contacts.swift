//
//  Contacts.swift
//  Contacts
//
//  Created by Waleed Saad on 1/18/19.
//  Copyright © 2019 Waleed Saad. All rights reserved.
//

import UIKit

struct Contact {
    var name: String
    
}

struct ContactsSection {
    var letter: String
    var isExpanded: Bool
    var contacts: [Contact]
}
