//
//  DetailsViewController.swift
//  MobileHostess
//
//  Created by Tristan Wolf on 2017-03-22.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController:UIViewController {
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantWaitTimeLabel: UILabel!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var restaurantImage: UIImageView!
    
    var restaurantName:String!
    var restaurantWaitTime:String!
    var restaurantAddress:String!
    var image:UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantNameLabel.text = restaurantName
        restaurantAddressLabel.text = restaurantAddress
        restaurantWaitTimeLabel.text = restaurantWaitTime
        restaurantImage.image = image
    }
    
}
