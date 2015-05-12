//
//  LSSavedContacts.swift
//  EliasContactApp
//
//  Created by Tucker Kirven on 5/7/15.
//  Copyright (c) 2015 Tucker Kirven. All rights reserved.
//

import UIKit

class LSSavedContacts: NSObject {
   
    var savedContacts = [LSContact]()
    
    func add(contact: LSContact)->(){
        print(contact.get(Account: .Name))
        savedContacts.append(contact)
    }
    func count() -> Int{
        return savedContacts.count
    }
}
