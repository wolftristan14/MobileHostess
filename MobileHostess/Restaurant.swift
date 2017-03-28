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
    
    var name:String
    var address:String
    
    let ref: FIRDatabaseReference?
    var key:String
    
    init(name: String, address: String, key: String = "") {
        
        self.name = name
        self.address = address
        self.key = key
        self.ref = nil
        
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        address = snapshotValue["address"] as! String
        key = snapshot.key
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return ["name": name, "address": address]
    }
    
}
