//
//  LSContact.swift
//  EliasContactApp
//
//  Created by Tucker Kirven on 5/6/15.
//  Copyright (c) 2015 Tucker Kirven. All rights reserved.
//

import Foundation

class LSContact {
    
    enum Account{
        case Facebook
        case Twitter
        case Snapchat
        case Instagram
        case LinkedIn
        case PrimaryEmail
        case SecondaryEmail
        case Name
        case PhoneNumber
    }
    var JSONTypeDict = [Account.Facebook:"fb",
        Account.Twitter:"twt",
        Account.Snapchat:"snp",
        Account.Instagram:"ins",
        Account.LinkedIn:"lkn",
        Account.PrimaryEmail:"em1",
        Account.SecondaryEmail:"em2",
        Account.Name:"nam",
        Account.PhoneNumber:"ph#"]
    
    var ProperNameDict = [Account.Facebook:"Facebook",
        Account.Twitter:"Twitter",
        Account.Snapchat:"Snapchat",
        Account.Instagram:"Instagram",
        Account.LinkedIn:"LinkedIn",
        Account.PrimaryEmail:"PrimaryEmail",
        Account.SecondaryEmail:"SecondaryEmail",
        Account.Name:"Name",
        Account.PhoneNumber:"Phone Number"]
    
    var NameToAccountTypeDict = ["Facebook":Account.Facebook,
        "Twitter":Account.Twitter,
        "Snapchat":Account.Snapchat,
        "Instagram":Account.Instagram,
        "LinkedIn":Account.LinkedIn,
        "PrimaryEmail":Account.PrimaryEmail,
        "SecondaryEmail":Account.SecondaryEmail,
        "Name":Account.Name,
        "Phone Number":Account.PhoneNumber]
    
    var UserNameDict = [Account:String]()
    
    var accounts = [LSAccount]()
    var accountTypes = [String]()
    init (FaceBook face:String, Twitter twit:String, Snapchat snap:String, Instagram insta:String, LinkedIn link:String, PrimaryEmail em1: String, SecondaryEmail em2: String){
        
       UserNameDict = [Account.Facebook:face,
                        Account.Twitter:twit,
                        Account.Snapchat:snap,
                        Account.Instagram:insta,
                        Account.LinkedIn:link,
                        Account.PrimaryEmail:em1,
                        Account.SecondaryEmail:em2]

        for (account, name) in ProperNameDict {
            accountTypes.append(name)
        }
        
    }
    init (QRJSONString str: String){
        
        for (act, name) in ProperNameDict {
            UserNameDict.updateValue("", forKey: act)
        }
        let substr = str.substringWithRange(Range<String.Index>(start: advance (str.startIndex, 3), end: str.endIndex))
        print( "attempt to parse and make dict: " + substr)
        let accountArray = JSONParseDictionary(substr) as! [String:String]
        
        for (type,name) in accountArray {
            print( "adding " + name + "for account type: " + type)
            let typeAct = NameToAccountTypeDict[type]
            UserNameDict.updateValue(name, forKey: typeAct!)
            accounts.append(LSAccount(Type: type, username: name))
        }
        
        
    }
    
    func get(Account a: Account)->String{
        let item = UserNameDict[a]! as String
        return item
      
  
    }
    func add(Account a: Account, newUserName: String)->(){
        var exists = false
        for account in accounts {
            if account.type == ProperNameDict[a] {
                account.name = newUserName
                exists = true
            }
        }
        if !exists {
            accounts.append(LSAccount(Type: ProperNameDict[a]!, username: newUserName))
        }
        
         set(Account: a, newUserName: newUserName)
    }
    func set(Account a: Account, newUserName: String)->(){
        UserNameDict.updateValue(newUserName, forKey: a)
    }
    func getContactString()->String{
     
        var sendDict = [String:String]()
        for thing in accounts {
            sendDict.updateValue(thing.name, forKey: thing.type)
        }
        var msgString = JSONStringify(sendDict, prettyPrinted: false)
        return msgString
    }

}
class LSAccount {
    
    var type:String
    var name:String
    
    init (Type type:String, username name:String){
        self.type = type
        self.name = name
    }
    
}