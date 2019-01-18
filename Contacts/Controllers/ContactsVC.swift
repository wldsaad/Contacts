//
//  ViewController.swift
//  Contacts
//
//  Created by Waleed Saad on 1/17/19.
//  Copyright © 2019 Waleed Saad. All rights reserved.
//

import UIKit
import SwipeCellKit

class ContactsVC: UIViewController, SwipeTableViewCellDelegate {
    
    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var contacts = [
        ContactsSection(letter: "W", isExpanded: true, contacts: [
            Contact(name: "Waleed"),
            Contact(name: "Willo"),
            Contact(name: "Weka")
            ]),
        ContactsSection(letter: "A", isExpanded: true, contacts: [
            Contact(name: "Ahmed"),
            Contact(name: "Ahmoda"),
            Contact(name: "Abo Hemaid")
            ]),
        ContactsSection(letter: "M", isExpanded: true, contacts: [
            Contact(name: "Mohamed"),
            Contact(name: "Mido"),
            Contact(name: "Momo")
            ])
    ]
    
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
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        
        let callAction = SwipeAction(style: SwipeActionStyle.default, title: "Call") { action, indexPath in
            // handle action by updating model with deletion
            debugPrint("Called")
        }
        let moreAction = SwipeAction(style: SwipeActionStyle.default, title: "More") { action, indexPath in
            // handle action by updating model with deletion
            debugPrint("More")
        }
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            debugPrint("Deleted")
        }
        
        // customize the action appearance
        callAction.image = UIImage(named: "call")
        callAction.backgroundColor = .green
        callAction.textColor = .black
        moreAction.image = UIImage(named: "more")
        moreAction.textColor = .black
        deleteAction.image = UIImage(named: "delete")
        
        return [callAction, deleteAction, moreAction]
    }
    
    
    
    
    

}

extension ContactsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactsTableView.dequeueReusableCell(withIdentifier: "contactCell") as! SwipeTableViewCell
        cell.delegate = self
        cell.textLabel?.text = contacts[indexPath.section].contacts[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !contacts[section].isExpanded {
            return 0
        }
        return contacts[section].contacts.count
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .fill
        options.transitionStyle = .reveal
        
        return options
    }
    
    

    
}
extension ContactsVC: UITableViewDelegate  {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let capitalLetterView = Bundle.main.loadNibNamed("ContactHeaderXib", owner: self, options: nil)?.first as? ContactHeaderXibView {
            capitalLetterView.letterLabel.text = contacts[section].letter
            capitalLetterView.expandButton.tag = section
            capitalLetterView.expandButton.addTarget(self, action: #selector(handleExpandtoggle(sender:)), for: .touchUpInside)
            return capitalLetterView
        }
        return ContactHeaderXibView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SECTION_HEIGHT
    }
    
    @objc private func handleExpandtoggle(sender: UIButton) {
        let section = sender.tag
        var indexPathes = [IndexPath]()
        for row in contacts[section].contacts.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPathes.append(indexPath)
        }
        contacts[section].isExpanded = !contacts[section].isExpanded
        if !contacts[section].isExpanded {
            contactsTableView.deleteRows(at: indexPathes, with: .fade)
        } else {
            contactsTableView.insertRows(at: indexPathes, with: .fade)
        }
        debugPrint(indexPathes)
    }
    
}
