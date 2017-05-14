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

protocol EditRestaurantViewControllerDelegate {
 
    func userDidGoToAddRestaurantViewController(name: String!, address: String!, partySizes: [String]!)
}

class EditRestaurantViewController:UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var waitTimeCategoryPickerView: UIPickerView!
    
    @IBOutlet weak var waitTimeLabel: UILabel!
    @IBOutlet weak var waitTimeTextField: UITextField!
    var waitTimesDictionary:[String: AnyObject] = [:]
    var categoryAndTimeArray = [(category:String, time:String)]()
    

    var categoryArray:[String] = []
    var currentCategory:String!
    
    var delegate: EditRestaurantViewControllerDelegate? = nil
  
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
            
            if userRestaurant.waitTimes != nil {
            
            for (category,time) in userRestaurant.waitTimes! {
                
                
            
            self.waitTimesDictionary.updateValue(time, forKey: category)
            self.categoryArray.append(category)
                
            }
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
        
        let waitTime:String = self.categoryAndTimeArray[row].1
        waitTimeLabel.text = "\(waitTime) Mins"
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
            
            self.waitTimeLabel.text = "\(waitTime) Mins"
        
        
        let updateRef = rootRef.child("\(key)")
            let currentTimeTimeStamp = Date.init(timeIntervalSinceNow: -7200)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let timeStamp = dateFormatter.string(from: currentTimeTimeStamp)
            
            
        
        updateRef.child("waitTimes").updateChildValues([self.currentCategory!: waitTime])
        updateRef.updateChildValues(["timeSinceLastUpdate": timeStamp])
            self.waitTimeTextField.text?.removeAll()
            viewDidLoad()
        

        }
    }

    @IBAction func goToAddRestaurantViewController(_ sender: Any) {
        let AddRestaurantVC = self.storyboard?.instantiateViewController(withIdentifier: "AddRestaurant")
        self.delegate = AddRestaurantVC as! EditRestaurantViewControllerDelegate?
        
        if delegate != nil {
        
        let restaurantName = restaurantNameLabel.text
        let restaurantAddress = restaurantAddressLabel.text
        present(AddRestaurantVC!, animated: true, completion: nil)
        delegate!.userDidGoToAddRestaurantViewController(name: restaurantName, address:restaurantAddress, partySizes: self.categoryArray)
        
        }
    }
    
    
}
