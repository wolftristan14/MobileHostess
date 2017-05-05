//
//  HomeViewController.swift
//  MobileHostess
//
//  Created by Tristan Wolf on 2017-03-22.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation


class HomeViewController:UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    var restaurantArray:[Restaurant] = []
    let ref = FIRDatabase.database().reference(withPath: "Restaurants")
    let locationManager = CLLocationManager()


    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
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
        let cellWaitTime:String = restaurant.waitTimes?.first?.value as! String!
        cell.restaurantWaitTime.text = "\(cellWaitTime) Mins"
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
            let detailWaitTime:String = restaurant.waitTimes?.first?.value as! String!
            detailsViewController.restaurantWaitTime = "\(detailWaitTime) Mins"
            detailsViewController.uuid = restaurant.uuid
            detailsViewController.imageURL = restaurant.imageURL
            detailsViewController.lastUpdateTime = restaurant.timeSinceLastUpdate
            
            detailsViewController.key = restaurant.key
            tableView.isEditing = false
            
            
        }
        
        
    }
    
    @IBAction func performSegueToMap(_ sender: Any) {
        performSegue(withIdentifier: "map", sender: self)
        
    }
    
    @IBAction func prepareToUnwindToHomeVC(segue:UIStoryboardSegue) {
        
    }
    @IBAction func logOut(_ sender: Any) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
  
}
