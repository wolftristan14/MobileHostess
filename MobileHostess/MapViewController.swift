//
//  MapViewController.swift
//  MobileHostess
//
//  Created by Tristan Wolf on 2017-04-26.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import MapKit

class MapViewController:UIViewController, UISearchBarDelegate {
    
    var searchController:UISearchController!

  
    @IBAction func showSearchBar(_ sender: Any) {
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
