//
//  HomeViewController.swift
//  MobileHostess
//
//  Created by Tristan Wolf on 2017-03-22.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController:UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var passedInfo:HomeTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "hometableviewcell", for: indexPath) as! HomeTableViewCell
        
        cell.restuarantImageView.image = #imageLiteral(resourceName: "Tom's_Restaurant,_NYC")
        cell.restaurantNameLabel.text = "Tom's Restaurant"
        cell.restaurantAddressLabel.text = "123 Fake st."
        cell.restaurantWaitTime.text = "30 mins"
        
        self.passedInfo = cell
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
       
            let detailsViewController:DetailsViewController = segue.destination as! DetailsViewController
            
            detailsViewController.restaurantName = self.passedInfo.restaurantNameLabel.text
            detailsViewController.restaurantAddress = self.passedInfo.restaurantAddressLabel.text
            detailsViewController.restaurantWaitTime = self.passedInfo.restaurantWaitTime.text
            detailsViewController.image = self.passedInfo.restuarantImageView.image
            
            
        }
    }
}
