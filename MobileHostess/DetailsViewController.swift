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
    @IBOutlet weak var lastUpdateTimeLabel: UILabel!
    
    var restaurantName:String!
    var restaurantWaitTime:String!
    var restaurantAddress:String!
    var lastUpdateTime:String!
    var imageURL:String!
    var uuid:String!
    var waitTimesDictionary:[String: AnyObject] = [:]
    var categoryAndTimeArray = [(String, String)]()

    
    let rootRef = FIRDatabase.database().reference(withPath: "Restaurants")

    
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        restaurantNameLabel.text = restaurantName
        restaurantAddressLabel.text = restaurantAddress
        restaurantWaitTimeLabel.text = restaurantWaitTime
        lastUpdateTimeLabel.text = lastUpdateTime
        
        let url = URL(string: imageURL)

            URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                DispatchQueue.main.async {
                    self.restaurantImage.image = UIImage(data: data!)
                    
                }
                
            }).resume()
        
        
        didLayoutSubviews()
    }
    
     func didLayoutSubviews() {
        

        let userRef = rootRef.child(uuid)
        
        userRef.observeSingleEvent(of: .value, with: {snapshot in
            
            let userRestaurant = Restaurant(snapshot: snapshot)
            
            for (category,time) in userRestaurant.waitTimes! {
                
                
                
                self.waitTimesDictionary.updateValue(time, forKey: category)
                
                
            }
            self.sortArray()
            
        })
    }

    
    
    func sortArray()  {
        for (category, time) in waitTimesDictionary {
          
            categoryAndTimeArray.append((category, time as! String))
            categoryAndTimeArray.sort {$0 > $1}
            
            }
        updateSegmentedControl()
       
    }
    
    func updateSegmentedControl() {
        partySizeSegmentedControl.removeAllSegments()

        for (category, _) in categoryAndTimeArray {
            partySizeSegmentedControl.insertSegment(withTitle: category, at: 0, animated: true)
            
        }
    }
  
        
    @IBAction func partySizeChanged(_ sender: Any) {
        let currentPartySize = partySizeSegmentedControl.titleForSegment(at: partySizeSegmentedControl.selectedSegmentIndex)
        
        let selectedWaitTime:String = (waitTimesDictionary[currentPartySize!] as! String?)!
        restaurantWaitTimeLabel.text = "\(selectedWaitTime) Mins"

    }
   
    @IBAction func backToHomeVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
