//
//  HomeViewController.swift
//  MobileHostess
//
//  Created by Tristan Wolf on 2017-03-22.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController:UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var restaurantArray:[Restaurant] = []
    let ref = FIRDatabase.database().reference(withPath: "Restaurants")


    
    @IBOutlet weak var tableView: UITableView!
    var passedInfo:HomeTableViewCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     ref.observe(.value, with: { snapshot in
        
        var newRestaurants:[Restaurant] = []
        
        for item in snapshot.children {
           
            let restaurant = Restaurant(snapshot: item as! FIRDataSnapshot)
        
            newRestaurants.append(restaurant)
        }
        
        
        self.restaurantArray = newRestaurants
        self.tableView.reloadData()
        
     }){
        (error) in
        print(error.localizedDescription)
        
        }
        
     
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "hometableviewcell", for: indexPath) as! HomeTableViewCell
        
        let restaurant = restaurantArray[indexPath.row]
        cell.restuarantImageView.image = #imageLiteral(resourceName: "Tom's_Restaurant,_NYC")
        cell.restaurantNameLabel.text = restaurant.name
        cell.restaurantAddressLabel.text = restaurant.address
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
