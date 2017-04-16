//
//  DetailsViewController.swift
//  MobileHostess
//
//  Created by Tristan Wolf on 2017-03-22.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class DetailsViewController:UIViewController {
    
    @IBOutlet weak var partySizeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantWaitTimeLabel: UILabel!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var restaurantImage: UIImageView!
    var key:String!
    
    var restaurantName:String!
    var restaurantWaitTime:String!
    var restaurantAddress:String!
    var image:UIImage!
    var waitTimesDictionary:[String: AnyObject] = [:]

    
    let rootRef = FIRDatabase.database().reference(withPath: "Restaurants")

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantNameLabel.text = restaurantName
        restaurantAddressLabel.text = restaurantAddress
        restaurantWaitTimeLabel.text = restaurantWaitTime
        restaurantImage.image = image
        
        
       // didLayoutSubviews()
    }
    
     func didLayoutSubviews() {
        

        let userRef = rootRef.child((FIRAuth.auth()?.currentUser?.uid)!)
        
        userRef.observeSingleEvent(of: .value, with: {snapshot in
            
            let userRestaurant = Restaurant(snapshot: snapshot)
            
            
            //self.restaurantNameLabel.text = userRestaurant.name
            // self.restaurantAddressLabel.text = userRestaurant.address
            
            for (category,time) in userRestaurant.waitTimes! {
                
                
                
                self.waitTimesDictionary.updateValue(time, forKey: category)
                
                
            }
            //  self.categoryArray = Array(self.waitTimesArray.keys)
            self.updateSegmentedControl()
            
        })
    }

    
    
    func updateSegmentedControl()  {
        for (category, _) in waitTimesDictionary {
          partySizeSegmentedControl.insertSegment(withTitle: category, at: 0, animated: true)
            
        }
    }
    
    
    
}
