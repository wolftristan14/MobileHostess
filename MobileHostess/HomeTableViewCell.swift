//
//  HomeTableViewCell.swift
//  MobileHostess
//
//  Created by Tristan Wolf on 2017-03-22.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit

class HomeTableViewCell:UITableViewCell {
    @IBOutlet weak var restuarantImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var restaurantWaitTime: UILabel!
    
    var uuid:String!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 0.2
    }
    
    
}
