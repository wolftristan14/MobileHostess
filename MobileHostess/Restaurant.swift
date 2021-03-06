//
//  Restaurant.swift
//  MobileHostess
//
//  Created by Tristan Wolf on 2017-03-27.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import Firebase


struct Restaurant {
    
    var name:String?
    var address:String?
    var waitTimes:[String : AnyObject]?
    var time:String?
    var imageURL:String?
    var uuid:String?
    var timeSinceLastUpdate:String?
    
    let ref: FIRDatabaseReference?
    var key:String
    
    init(name: String, address: String, waitTimes: [String: AnyObject], key: String = "", imageURL: String, uuid:String, timeSinceLastUpdate: String) {
        
        self.name = name
        self.address = address
        self.waitTimes = waitTimes
        self.imageURL = imageURL
        self.key = key
        self.uuid = uuid
        self.timeSinceLastUpdate = timeSinceLastUpdate
        self.ref = nil
        
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as? [String: AnyObject]
        name = snapshotValue?["name"] as? String
        address = snapshotValue?["address"] as? String
        waitTimes = snapshotValue?["waitTimes"] as? [String: AnyObject]
        time = waitTimes?["time"] as? String
        imageURL = snapshotValue?["imageURL"] as? String
        uuid = snapshotValue?["uuid"] as? String
        timeSinceLastUpdate = snapshotValue?["timeSinceLastUpdate"] as? String
        key = snapshot.key
        ref = snapshot.ref
        
    }
    
    func toAnyObject() -> Any {
        return ["name": name ?? "", "address": address ?? "", "waitTimes": waitTimes!, "imageURL": imageURL ?? "", "uuid": uuid ?? "", "timeSinceLastUpdate": timeSinceLastUpdate ?? "error getting date"]
    }
    
}
