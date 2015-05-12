//
//  MyInfoViewController.swift
//  EliasContactApp
//
//  Created by Tucker Kirven on 5/6/15.
//  Copyright (c) 2015 Tucker Kirven. All rights reserved.
//

import UIKit

class MyInfoViewController: UIViewController, UITableViewDelegate{
    

    @IBOutlet weak var contactTable: UITableView!
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var myContact:LSContact?
    
    var tabledata:MyData?
    
    func addPressed(sender: UIButton!){
        print("HERE!")
        var newAccount = NewAccountVC(nibName: "NewAccountVC", bundle: nil)
        
        presentViewController(newAccount, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myContact = appDelegate.myContact
       
        var add = UIButton.buttonWithType(.Custom) as! UIButton
        add.frame = CGRectMake(view.frame.width - (55 + 20), 20, 55, 55)
        add.layer.cornerRadius = 0.5 * add.bounds.size.width
        add.backgroundColor = UIColor.darkGrayColor()
        add.layer.shadowOffset = CGSizeMake(-5, 2)
        add.layer.shadowOpacity = 0.5
        add.setTitle("+", forState: .Normal)
        add.titleLabel?.textColor = UIColor.whiteColor()
        add.titleLabel?.font = add.titleLabel!.font.fontWithSize(25)
    
    
        add.addTarget(self, action: "addPressed:", forControlEvents: .TouchUpInside)
        view.addSubview(add)
        view.bringSubviewToFront(add)
            tabledata = MyData()
            contactTable.dataSource = tabledata
            contactTable.delegate = self
      
        contactTable.separatorColor = UIColor.clearColor()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        myContact = appDelegate.myContact
        tabledata = MyData()
        contactTable.dataSource = tabledata
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print(section)
        let headerView  = UIView()
        
        headerView.backgroundColor = UIColor.clearColor();
        
        return headerView;
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
class MyData: NSObject, UITableViewDataSource, UITableViewDelegate{
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var myContact:LSContact?
    /* func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = UITableViewCell()
        cell.textLabel.text = "a row"
        return cell
    }*/
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return appDelegate.myContact!.accounts.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell { // insert code
        var  cell:CustomCellVC! = tableView.dequeueReusableCellWithIdentifier("custCell2") as? CustomCellVC

        if (cell == nil)
        {
            let nib:Array = NSBundle.mainBundle().loadNibNamed("custCell2", owner: self, options: nil)
            cell = nib[0] as? CustomCellVC
        }
        var myAccounts = appDelegate.myContact?.accounts
        if (myAccounts?.count != 0 ){
        var account = myAccounts![indexPath.section]
        var type = account.type
        var name = account.name
            //cell.textLabel?.text = type
            cell.label1.text = type
            cell.sublabel2.text = name
            
       
            cell.backgroundColor = UIColor.lightGrayColor()
            cell.layer.cornerRadius = 5
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // insert code
        return 1
    }
  

    
    
}
