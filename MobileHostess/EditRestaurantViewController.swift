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
    var waitTimesDictionary:[String: AnyObject] = [:]
    var categoryAndTimeArray = [(String, String)]()

    var categoryArray:[String]!
    var timeArray:[String]!
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
            self.waitTimesDictionary.removeAll()
            for (category,time) in userRestaurant.waitTimes! {
                
                
            
            self.waitTimesDictionary.updateValue(time, forKey: category)
            
                
            }
            
            self.updatePickerView()

        
        })
        
        
        
        
        
    }
    
    func updatePickerView() {
        self.categoryAndTimeArray.removeAll()
        for (category, time) in waitTimesDictionary {
            self.categoryAndTimeArray.append((category, time as! String))
            
            self.categoryAndTimeArray.sort {$0 < $1}
        }
        self.waitTimeCategoryPickerView.reloadAllComponents()
     }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return categoryAndTimeArray.count
       
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        waitTimeLabel.text = self.categoryAndTimeArray[row].1
        return self.categoryAndTimeArray[row].0

       
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currentCategory = self.categoryAndTimeArray[row].0
        
        }
    
    @IBAction func updateWaitTime(_ sender: Any) {
        print("updatingWaitTime")
        
        let key = rootRef.child((FIRAuth.auth()?.currentUser?.uid)!).key
        
        var waitTime:String
        
        if self.waitTimeTextField.text != nil && self.waitTimeTextField.text != "" {
            waitTime = self.waitTimeTextField.text!
            self.waitTimeLabel.text = self.waitTimeTextField.text
        
        
        let updateRef = rootRef.child("\(key)")
        
        
        updateRef.child("waitTimes").updateChildValues([self.currentCategory!: waitTime])
            self.waitTimeTextField.text?.removeAll()
            viewDidLoad()

        }
    }

 
    
}
