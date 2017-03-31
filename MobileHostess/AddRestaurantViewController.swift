//
//  AddRestaurantViewController.swift
//  MobileHostess
//
//  Created by Tristan Wolf on 2017-03-22.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class AddRestaurantViewController:UIViewController {
    
    
    
    
    
    @IBOutlet weak var restaurantNameLabel: UITextField!
    @IBOutlet weak var restaurantAddressLabel: UITextField!
    @IBOutlet weak var partySizeLabel1: UITextField!
    @IBOutlet weak var partySizeLabel2: UITextField!
    @IBOutlet weak var partySizeLabel3: UITextField!
    @IBOutlet weak var partySizeLabel4: UITextField!
    @IBOutlet weak var partySizeLabel5: UITextField!
    @IBOutlet weak var partySizeLabel6: UITextField!
    @IBOutlet weak var partySizeLabel7: UITextField!
    @IBOutlet weak var partySizeLabel8: UITextField!
    @IBOutlet weak var partySizeLabel9: UITextField!
    @IBOutlet weak var restaurantImage: UIImageView!
    
    var databaseRef:FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func choosePhotoFromLibrary(_ sender: Any) {
    }
    
    @IBAction func takePhoto(_ sender: Any) {
    }
    
    @IBAction func done(_ sender: Any) {
        print("writing to database")
        
        let restaurantRef =  databaseRef.child("Restaurants").childByAutoId()
        
        var name: String!
        if restaurantNameLabel.text != nil {
            name = self.restaurantNameLabel.text
        }
        
        var address: String!
        if restaurantAddressLabel.text != nil {
            address = self.restaurantAddressLabel.text
        }
        
        var waitTimes: [String] = []
        var waitTime:String
        
        if partySizeLabel1 != nil {
            waitTime = self.partySizeLabel1.text!
            waitTimes.append(waitTime)
        }
        if partySizeLabel2 != nil {
            waitTime = self.partySizeLabel2.text!
            waitTimes.append(waitTime)
        }
        if partySizeLabel3 != nil {
            waitTime = self.partySizeLabel3.text!
            waitTimes.append(waitTime)
        }
        if partySizeLabel4 != nil {
            waitTime = self.partySizeLabel4.text!
            waitTimes.append(waitTime)
        }
        if partySizeLabel5 != nil {
            waitTime = self.partySizeLabel5.text!
            waitTimes.append(waitTime)
        }
        if partySizeLabel6 != nil {
            waitTime = self.partySizeLabel6.text!
            waitTimes.append(waitTime)
        }
        if partySizeLabel7 != nil {
            waitTime = self.partySizeLabel7.text!
            waitTimes.append(waitTime)
        }
        if partySizeLabel8 != nil {
            waitTime = self.partySizeLabel8.text!
            waitTimes.append(waitTime)
        }
        if partySizeLabel9 != nil {
            waitTime = self.partySizeLabel9.text!
            waitTimes.append(waitTime)
        }
        
        let restaurant = Restaurant(name: name, address: address, waitTimes: waitTimes)
        
        restaurantRef.setValue(restaurant.toAnyObject())
        
    }
}
