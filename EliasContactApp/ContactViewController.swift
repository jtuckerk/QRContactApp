//
//  ContactViewController.swift
//  EliasContactApp
//
//  Created by Tucker Kirven on 5/7/15.
//  Copyright (c) 2015 Tucker Kirven. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
    
    @IBOutlet weak var back: UIButton!
    
    @IBAction func backclick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var contactsTable: UITableView!
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var contact:LSContact?
    
    var tabledata:ContactData?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tabledata = ContactData(contact: contact!)
        contactsTable.dataSource = tabledata
        contactsTable.separatorColor = UIColor.clearColor()
    }
    override func viewWillAppear(animated: Bool) {
        tabledata = ContactData(contact: contact!)
        contactsTable.dataSource = tabledata
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
class ContactData: NSObject, UITableViewDataSource{
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var contact:LSContact?
    
    init (contact: LSContact){
        super.init()
        self.contact = contact
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell { // insert code
        let cell = UITableViewCell()
        
        
        let account = contact?.accounts[indexPath.row]
        let type = account?.type
        let name = account?.name
            cell.textLabel?.text = type! + ": " + name!
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // insert code
        var num = contact?.accounts.count
        return num!
    }
    
}