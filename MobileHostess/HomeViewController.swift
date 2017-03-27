//
//  HomeViewController.swift
//  MobileHostess
//
//  Created by Tristan Wolf on 2017-03-22.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class HomeViewController:UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref:FIRDatabaseReference?
    var restaurantArray = [String]()
    var addressArray = [String]()
    var databaseHandle:FIRDatabaseHandle?

    
    @IBOutlet weak var tableView: UITableView!
    var passedInfo:HomeTableViewCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     ref = FIRDatabase.database().reference()
        
        databaseHandle = ref?.child("Restaurants").observe(.childAdded, with: {(snapshot) in
        
            
            
            let restaurantData = snapshot.value as? String
            
            if restaurantData != nil && restaurantData != "" {
                self.restaurantArray.append(snapshot.value as! String)
            }
            
            self.tableView.reloadData()
        
        })
        
        databaseHandle = ref?.child("Addresses").observe(.childAdded, with: {(snapshot) in
        
        let addressData = snapshot.value as? String
            
            if addressData != nil && addressData != "" {
                self.addressArray.append(snapshot.value as! String)
            }
        self.tableView.reloadData()
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "hometableviewcell", for: indexPath) as! HomeTableViewCell
        
        let restaurant:String = self.restaurantArray[indexPath.row]
        let address:String = self.addressArray[indexPath.row]
        cell.restuarantImageView.image = #imageLiteral(resourceName: "Tom's_Restaurant,_NYC")
        cell.restaurantNameLabel.text = restaurant
        cell.restaurantAddressLabel.text = address
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
