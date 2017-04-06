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

class EditRestaurantViewController:UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var waitTimeCategoryPickerView: UIPickerView!
    
    @IBOutlet weak var waitTimeLabel: UILabel!
    @IBOutlet weak var waitTimeTextField: UITextField!
    var waitTimesArray:[String] = []
    var currentCategory:String!
  
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
            
           // for category,time in userRestaurant.waitTimes! {
                
            //    if time != "" {
            
          //  self.waitTimesArray.append(time)
                    
          //      }
          //  }
            self.waitTimeCategoryPickerView.reloadAllComponents()
        
        })
        
        
        
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return waitTimesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return waitTimesArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currentCategory = waitTimesArray[row]
        }
    
   /* @IBAction func saveWaitTimeForCategory(_ sender: Any) {
        
        let timeRef = rootRef.child((FIRAuth.auth()?.currentUser?.uid)!).child("waitTimes")
        var time:String?
        if self.currentCategory ==  {
        
        if waitTimeTextField != nil {
            time = waitTimeTextField.text!
            waitTimeLabel.text = time
            }
            
        }
    }*/
 
    
}
