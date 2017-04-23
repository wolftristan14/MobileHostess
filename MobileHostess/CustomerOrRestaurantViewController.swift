//
//  CustomerOrRestaurantViewController.swift
//  MobileHostess
//
//  Created by Tristan Wolf on 2017-04-23.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit

class CustomerOrRestaurantViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Customers" {
            let loginViewController:LoginViewController = segue.destination as! LoginViewController
            
        }
        
        if segue.identifier == "Restaurants" {
            let restaurantLoginViewController:RestaurantLoginViewController = segue.destination as! RestaurantLoginViewController
        }
    }
    
    @IBAction func prepareToUnwindToCustomerOrRestaurantVC(segue:UIStoryboardSegue) {
        
    }
  
    
    
}
