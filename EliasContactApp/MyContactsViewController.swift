//
//  MyContactsViewController.swift
//  EliasContactApp
//
//  Created by Tucker Kirven on 5/7/15.
//  Copyright (c) 2015 Tucker Kirven. All rights reserved.
//

import UIKit

class MyContactsViewController: UIViewController, UITableViewDelegate  {
    
    @IBOutlet weak var contactsTable: UITableView!
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var myContact:LSContact?
    var myContacts:[LSContact]?
    
    var tabledata:MyContactsData?
    override func viewDidLoad() {
       
        
        super.viewDidLoad()
        myContact = appDelegate.myContact
        myContacts = appDelegate.contactList.savedContacts
            tabledata = MyContactsData()
            contactsTable.dataSource = tabledata
            contactsTable.delegate = self
        
        contactsTable.separatorColor = UIColor.clearColor()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        myContact = appDelegate.myContact
        myContacts = appDelegate.contactList.savedContacts
        tabledata = MyContactsData()
        contactsTable.dataSource = tabledata
        contactsTable.delegate = self
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("AAAAAAa")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var contactVC = ContactViewController(nibName: "ContactViewController", bundle: nil)
        contactVC.contact = myContacts![indexPath.row]
        presentViewController(contactVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
class MyContactsData: NSObject, UITableViewDataSource{
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
     var myContacts:[LSContact]?
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell { // insert code
        let cell = UITableViewCell()
        myContacts = appDelegate.contactList.savedContacts
        if (myContacts!.count != 0 ){
            var contact = myContacts![indexPath.row]
        
            cell.textLabel?.text = contact.get(Account: LSContact.Account.Name)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // insert code
        var num = appDelegate.contactList.count()
        return num
    }

}