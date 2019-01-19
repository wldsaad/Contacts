//
//  Contacts.swift
//  Contacts
//
//  Created by Waleed Saad on 1/18/19.
//  Copyright © 2019 Waleed Saad. All rights reserved.
//

import UIKit
import RealmSwift

class Contact: Object {
    @objc dynamic var name = ""
    @objc dynamic var phone = ""
    @objc dynamic var isFavorited = false
    @objc dynamic var color = ""


}

class ContactsSection: Object {
    @objc dynamic var letter = ""
    @objc dynamic var isExpanded = true
    var contacts = List<Contact>()
}
