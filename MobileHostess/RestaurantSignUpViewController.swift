//
//  RestaurantSignUpViewController.swift
//  MobileHostess
//
//  Created by Tristan Wolf on 2017-03-22.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class RestaurantSignUpViewController:UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
  
    
    
    
    @IBAction func restaurantSignUp(_ sender: Any) {
        
        if emailTextField.text == "" || passwordTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "You must enter a username and password", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(alertAction)
            
            present(alertController, animated: true, completion: nil)
        } else {
            FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!){(user, error) in
                
                if error == nil {
                    print("Signup was successful")
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddRestaurant")
                    self.present(vc!, animated: true, completion: nil)
                    
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }
        }
    }
}
