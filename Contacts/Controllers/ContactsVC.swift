//
//  ViewController.swift
//  Contacts
//
//  Created by Waleed Saad on 1/17/19.
//  Copyright © 2019 Waleed Saad. All rights reserved.
//

import UIKit
import SwipeCellKit
import RealmSwift

class ContactsVC: UIViewController, SwipeTableViewCellDelegate {
    
    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let realm = try! Realm()
    
    private var contacts: Results<ContactsSection>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearSearchbarBackground()
        getContacts()
        debugPrint(realm.configuration.fileURL)
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
    
    private func getContacts(){
        contacts = realm.objects(ContactsSection.self).sorted(byKeyPath: "letter")
    }
    
    @IBAction func addContactButtonPressed(_ sender: UIBarButtonItem) {
        showAddAlert()
    }
    
    private func showAddAlert(){
        let addAlert = UIAlertController(title: "Add contact", message: "", preferredStyle: .alert)
        var nameTextField = UITextField()
        var phoneTextField = UITextField()
        addAlert.addTextField { (nameField) in
            nameField.placeholder = "Name"
            nameTextField = nameField
        }
        addAlert.addTextField { (phoneField) in
            phoneField.placeholder = "Phone"
            phoneTextField = phoneField
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            guard let name = nameTextField.text, let phone = phoneTextField.text else {
                return
            }
            if name.count > 0 , phone.count > 0 {
                self.saveContact(name: name, phone: phone)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            addAlert.dismiss(animated: true, completion: nil)
        }
        addAlert.addAction(addAction)
        addAlert.addAction(cancelAction)
        present(addAlert, animated: true, completion: nil)
    }
    
    private func saveContact(name: String, phone: String) {
        let section = realm.objects(ContactsSection.self).filter("letter CONTAINS [cd] %@", String(name.first!))
        let contact = Contact()
        contact.name = name
        contact.phone = phone
        if section.count == 0 {
            do {
                try realm.write {
                    let newSection = ContactsSection()
                    newSection.letter = String(name.first!).capitalized
                    newSection.isExpanded = true
                    newSection.contacts.append(contact)
                    realm.add(newSection)
                    DispatchQueue.main.async {
                        self.contactsTableView.reloadData()
                    }
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        } else {
            
            do {
                try realm.write {
                    let oldContacts = section[0].contacts
                    oldContacts.append(contact)
                    section[0].contacts = oldContacts
                    realm.add(section)
                    DispatchQueue.main.async {
                        self.contactsTableView.reloadData()
                    }
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
            
        }
    }
    
    private func deleteContact(indexPath: IndexPath){
        do {
            try realm.write {
                realm.delete(contacts![indexPath.section].contacts[indexPath.row])
                if let newContacts = contacts?[indexPath.section].contacts {
                    if newContacts.count == 0 {
                        realm.delete(contacts![indexPath.section])
                    }
                }
                DispatchQueue.main.async {
                    self.contactsTableView.reloadData()
                }
            }
        } catch {
            
        }
    }
    
    private func callContact(indexPath: IndexPath) {
        let number = contacts?[indexPath.section].contacts[indexPath.row].phone
        if let url = URL(string: "tel://\(number!)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
            self.contactsTableView.reloadData()
        } else {
            debugPrint("ERROR")
        }
    }

}

extension ContactsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        
        let callAction = SwipeAction(style: SwipeActionStyle.default, title: "Call") { action, indexPath in
            self.callContact(indexPath: indexPath)
        }
        let moreAction = SwipeAction(style: SwipeActionStyle.default, title: "More") { action, indexPath in
            // handle action by updating model with deletion
        }
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.deleteContact(indexPath: indexPath)
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

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = contactsTableView.dequeueReusableCell(withIdentifier: "contactCell") as? ContactCell {
            cell.delegate = self
            cell.updateViews(contact: contacts?[indexPath.section].contacts[indexPath.row] ?? Contact())
            cell.contactsVC = self
            return cell
        }
        return ContactCell()
    }
    
    func handleFav(cell: ContactCell){
        if let indexPath = contactsTableView.indexPath(for: cell) {
            do {
                try realm.write {
                    contacts?[indexPath.section].contacts[indexPath.row].isFavorited = !(contacts?[indexPath.section].contacts[indexPath.row].isFavorited)!
                    DispatchQueue.main.async {
                        cell.updateViews(contact: (self.contacts?[indexPath.section].contacts[indexPath.row])!)
                    }
                }
                
            } catch {
                debugPrint(error.localizedDescription)
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !(contacts?[section].isExpanded)! {
            return 0
        }
        return (contacts?[section].contacts.count)!
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
        return contacts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let capitalLetterView = Bundle.main.loadNibNamed("ContactHeaderXib", owner: self, options: nil)?.first as? ContactHeaderXibView {
            capitalLetterView.letterLabel.text = contacts?[section].letter
            capitalLetterView.expandButton.tag = section
            capitalLetterView.expandButton.addTarget(self, action: #selector(handleExpandtoggle(sender:)), for: .touchUpInside)
            capitalLetterView.expandButton.imageView?.image = (contacts?[section].isExpanded)! ? UIImage(named: "up_arrow") : UIImage(named: "down_arrow")
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
        for row in (contacts?[section].contacts.indices)! {
            let indexPath = IndexPath(row: row, section: section)
            indexPathes.append(indexPath)
        }
        do {
            try realm.write {
                contacts?[section].isExpanded = !contacts![section].isExpanded
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
        if !(contacts?[section].isExpanded)! {
            contactsTableView.deleteRows(at: indexPathes, with: .fade)
        } else {
            contactsTableView.insertRows(at: indexPathes, with: .fade)
        }
        contactsTableView.reloadSections(IndexSet(arrayLiteral: section), with: .none)
    }
    
}
