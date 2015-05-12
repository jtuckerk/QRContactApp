//
//  ViewController.swift
//  EliasContactApp
//
//  Created by Tucker Kirven on 5/6/15.
//  Copyright (c) 2015 Tucker Kirven. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var firstOpen = true
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    @IBOutlet weak var QRView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var strContact = appDelegate.myContact?.getContactString()
        print(strContact)
        let qrimg = QRCode("XYZ" + strContact!)
        QRView.image = qrimg?.image
        
    }
    
    override func viewWillAppear(animated: Bool) {
        var strContact = appDelegate.myContact?.getContactString()
        print(strContact)
        let qrimg = QRCode("XYZ" + strContact!)
        QRView.image = qrimg?.image
    }
    override func viewDidAppear(animated: Bool) {
        if (firstOpen){
            print( "here")
            var alert = UIAlertController(title: "Welcome!", message: "Please Enter Your Full Name", preferredStyle: .Alert)
            
            //2. Add the text field. You can configure it however you need.
            alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                textField.text = "Name"
            })
            
            //3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                let textField = alert.textFields![0] as! UITextField
                textField
                self.appDelegate.myContact?.add(Account: LSContact.Account.Name, newUserName: textField.text)
            }))
            
            // 4. Present the alert.
            self.presentViewController(alert, animated: true, completion: nil)
            firstOpen = false
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

