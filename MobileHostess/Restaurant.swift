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
    var waitTimes:[String]
    var imageURL:String?
    
    let ref: FIRDatabaseReference?
   // var key:String
    
    init(name: String, address: String, waitTimes: [String]/*, key: String = ""*/, imageURL: String) {
        
        self.name = name
        self.address = address
        self.waitTimes = waitTimes
        self.imageURL = imageURL
        //self.key = key
        self.ref = nil
        
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        address = snapshotValue["address"] as! String
        waitTimes = snapshotValue["waitTimes"] as! [String]
        imageURL = snapshotValue["imageURL"] as? String
       // key = snapshot.key
        ref = snapshot.ref
        
    }
    
    func toAnyObject() -> Any {
        return ["name": name, "address": address, "waitTimes": waitTimes, "imageURL": imageURL ?? ""]
    }
    
}
