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


class HomeViewController:UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, UISearchBarDelegate {
    
    var restaurantArray:[Restaurant] = []
    var filteredRestaurantArray:[Restaurant] = []
    var restaurantNameArray:[String] = []
    let ref = FIRDatabase.database().reference(withPath: "Restaurants")
    let locationManager = CLLocationManager()
    

    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBarHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var searchBar: UISearchBar!
    var isSearching = false
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.isHidden = true
        
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        
        
     ref.observe(.value, with: { snapshot in

        
        
        var newRestaurants:[Restaurant] = []
        
        for item in snapshot.children {
           
            let restaurant = Restaurant(snapshot: item as! FIRDataSnapshot)
        
    
            newRestaurants.append(restaurant)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()

            }
        }

        self.restaurantArray = newRestaurants

        print(self.restaurantArray)
        
     }){
        (error) in
        print(error.localizedDescription)
        
        }
        
     
        
    }
    
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching == true {
           return filteredRestaurantArray.count
        } else {
        return restaurantArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "hometableviewcell", for: indexPath) as! HomeTableViewCell
        
        if isSearching == true {
            let restaurant = filteredRestaurantArray[indexPath.row]
            cell.restaurantNameLabel.text = restaurant.name
            cell.restaurantAddressLabel.text = restaurant.address
            let cellWaitTime:String = restaurant.waitTimes?.first?.value as? String ?? ""
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
        } else {
            let restaurant = restaurantArray[indexPath.row]
        
        cell.restaurantNameLabel.text = restaurant.name
        restaurantNameArray.append(restaurant.name!)
        cell.restaurantAddressLabel.text = restaurant.address
        let cellWaitTime:String = restaurant.waitTimes?.first?.value as? String ?? ""
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
  
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            
            view.endEditing(true)
            tableView.reloadData()
        } else {
            isSearching = true
            filteredRestaurantArray = restaurantArray.filter {$0.name == searchBar.text}
            tableView.reloadData()
        }
    }
    
    @IBAction func showSearchBar(_ sender: Any) {
        if searchBar.isHidden == true {
        searchBar.isHidden = false
            UIView.animate(withDuration: 0.5, animations: {self.searchBarHeightConstraint.constant = 44; self.tableViewHeightConstraint.constant = 559; self.view.layoutSubviews()})
        } else {
            searchBar.isHidden = true
            UIView.animate(withDuration: 0.5, animations: {self.searchBarHeightConstraint.constant = 0; self.tableViewHeightConstraint.constant = 603; self.view.layoutSubviews()})
        }
        
    }
}
