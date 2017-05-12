//
//  MapViewController.swift
//  MobileHostess
//
//  Created by Tristan Wolf on 2017-04-26.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import Firebase
import MapKit

class MapViewController:UIViewController, UISearchBarDelegate {
    
    let ref = FIRDatabase.database().reference(withPath: "Restaurants")

    var locationManager = CLLocationManager()

    
    var searchController:UISearchController!
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let latitude:CLLocationDegrees = (locationManager.location?.coordinate.latitude)!
        let longitude:CLLocationDegrees = (locationManager.location?.coordinate.longitude)!
        let latDelta:CLLocationDegrees = 0.05
        let lonDelta:CLLocationDegrees = 0.05
        let span = MKCoordinateSpanMake(latDelta, lonDelta)
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        let region = MKCoordinateRegionMake(location, span)
        
        mapView.setRegion(region, animated: false)
        
      ref.observe(.value, with: { snapshot in
            
            var newRestaurants:[Restaurant] = []
            
            for item in snapshot.children {
                
                let restaurant = Restaurant(snapshot: item as! FIRDataSnapshot)
                
                newRestaurants.append(restaurant)
                
                self.loadAnnotations(restaurantAddress:"\(restaurant.name!), \(restaurant.address!)")

            }
            
            
        }){
            (error) in
            print(error.localizedDescription)
            
        }
    }
    
    func loadAnnotations(restaurantAddress:String) {
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = restaurantAddress
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start { (localSearchResponse, error) -> Void in
            
            if localSearchResponse == nil{
                let alertController = UIAlertController(title: nil, message: "Address Not Found", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            self.pointAnnotation = MKPointAnnotation()
            self.pointAnnotation.title = restaurantAddress
            self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
            
            
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
            self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
        }
        
    }

  
   

    
   
    
}
