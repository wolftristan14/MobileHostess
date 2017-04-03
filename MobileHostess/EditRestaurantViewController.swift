//
//  EditRestaurantViewController.swift
//  MobileHostess
//
//  Created by Tristan Wolf on 2017-03-22.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class EditRestaurantViewController:UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var waitTimeCategoryPickerView: UIPickerView!
    
    @IBOutlet weak var waitTimePickerView: UIPickerView!
    var waitTimesArray:[String] = []
  
    let rootRef = FIRDatabase.database().reference(withPath: "Restaurants")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        waitTimeCategoryPickerView.delegate = self
        waitTimeCategoryPickerView.dataSource = self
       
        
        
        
        let userRef = rootRef.child((FIRAuth.auth()?.currentUser?.uid)!)
        
        userRef.observeSingleEvent(of: .value, with: {snapshot in
        
      let userRestaurant = Restaurant(snapshot: snapshot)
            
            self.restaurantNameLabel.text = userRestaurant.name
            self.restaurantAddressLabel.text = userRestaurant.address
            
            for time in userRestaurant.waitTimes {
                
                if time != "" {
            
            self.waitTimesArray.append(time)
                    
                }
            }
            self.waitTimeCategoryPickerView.reloadAllComponents()
        
        })
        
        
        
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.waitTimesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.waitTimesArray[row]
    }
   
    
}
