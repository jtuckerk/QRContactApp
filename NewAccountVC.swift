//
//  NewAccountVC.swift
//  EliasContactApp
//
//  Created by Tucker Kirven on 5/11/15.
//  Copyright (c) 2015 Tucker Kirven. All rights reserved.
//

import UIKit

class NewAccountVC: UIViewController, UITextFieldDelegate {
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBAction func DoneClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addButton(sender: AnyObject) {
        var selRow = AccountTypeScrollView.selectedRowInComponent(0)
        var type = pData?.pickerView(AccountTypeScrollView, titleForRow: selRow, forComponent: 0)
        var typeAct = appDelegate.myContact?.NameToAccountTypeDict[type!]
        var name = usernameEntryField.text
        appDelegate.myContact?.add(Account:  typeAct!, newUserName: name)
        
        usernameEntryField.text = ""
        print(appDelegate.myContact?.accounts)
    }
    @IBOutlet weak var AccountTypeScrollView: UIPickerView!
    @IBOutlet weak var usernameEntryField: UITextField!
    
    var pData:PickerData?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameEntryField.delegate = self
        pData = PickerData()
        AccountTypeScrollView.delegate = pData
        AccountTypeScrollView.dataSource = pData
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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

class PickerData: NSObject, UIPickerViewDataSource, UIPickerViewDelegate{
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var acntTypes = appDelegate.myContact?.accountTypes
        return  acntTypes!.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        var acntTypes = appDelegate.myContact?.accountTypes
        return  acntTypes![row]
        
    }
    
}