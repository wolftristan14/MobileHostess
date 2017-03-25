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
    
    var ref: FIRDatabaseReference?
    
    
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
    }
    
    @IBAction func choosePhotoFromLibrary(_ sender: Any) {
    }
    
    @IBAction func takePhoto(_ sender: Any) {
    }
    
    @IBAction func done(_ sender: Any) {
        ref?.child("Restaurants").child("Name").setValue(restaurantNameLabel.text)
        ref?.child("Restaurants").child("Address").setValue(restaurantAddressLabel.text)
        
        ref?.child("Restaurants").child("PartySizes").child("PartySize1").setValue(partySizeLabel1.text)
        ref?.child("Restaurants").child("PartySizes").child("PartySize2").setValue(partySizeLabel2.text)
        ref?.child("Restaurants").child("PartySizes").child("PartySize3").setValue(partySizeLabel3.text)
        ref?.child("Restaurants").child("PartySizes").child("PartySize4").setValue(partySizeLabel4.text)
        ref?.child("Restaurants").child("PartySizes").child("PartySize5").setValue(partySizeLabel5.text)
        ref?.child("Restaurants").child("PartySizes").child("PartySize6").setValue(partySizeLabel6.text)
        ref?.child("Restaurants").child("PartySizes").child("PartySize7").setValue(partySizeLabel7.text)
        ref?.child("Restaurants").child("PartySizes").child("PartySize8").setValue(partySizeLabel8.text)
        ref?.child("Restaurants").child("PartySizes").child("PartySize9").setValue(partySizeLabel9.text)

        //ref?.child("Restaurants").child("Image").setValue(restaurantImage.image)
    }
}
