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
    var passedImage:UIImage!


    
    @IBOutlet weak var tableView: UITableView!
    
    
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
        cell.restaurantNameLabel.text = restaurant.name
        cell.restaurantAddressLabel.text = restaurant.address
        cell.restaurantWaitTime.text = restaurant.waitTimes?.first?.value as! String!
        cell.uuid = restaurant.uuid
        
        if let imageURL = restaurant.imageURL {
            let url = URL(string: imageURL)
            URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            
                if error != nil {
                    print(error!)
                    return
                }
                
                DispatchQueue.main.async {
                    cell.restuarantImageView.image = UIImage(data: data!)
                    
                }
            
            }).resume()

        }
        
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
       
            let detailsViewController:DetailsViewController = segue.destination as! DetailsViewController
            
            let indexPath = tableView.indexPathForSelectedRow?.row
            let restaurant = restaurantArray[indexPath!]
            detailsViewController.restaurantName = restaurant.name
            detailsViewController.restaurantAddress = restaurant.address
            detailsViewController.restaurantWaitTime = restaurant.waitTimes?.first?.value as! String!
            detailsViewController.uuid = restaurant.uuid
            detailsViewController.imageURL = restaurant.imageURL //fix this image isnt being passed
            
            
            detailsViewController.key = restaurant.key
            
        }
    }
}
