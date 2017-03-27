//
//  Restaurant.swift
//  MobileHostess
//
//  Created by Tristan Wolf on 2017-03-27.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct Restaurant {
    
    var name:String!
    var address:String!
    
    var ref: FIRDatabaseReference?
    var key:String!
    
    init(name: String, address: String, key: String = "") {
        
        self.name = name
        self.address = address
        self.key = key
        self.ref = FIRDatabase.database().reference()
        
    }
    
    init(snapshot: FIRDataSnapshot) {
        self.name = snapshot.value(forKey: "name") as! String
        self.address = snapshot.value(forKey: "address") as! String
        self.key = snapshot.key
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> [String: AnyObject] {
        return ["name": name as AnyObject, "address": address as AnyObject]
    }
    
}
