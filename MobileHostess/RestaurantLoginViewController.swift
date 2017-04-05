//
//  RestaurantLoginViewController.swift
//  MobileHostess
//
//  Created by Tristan Wolf on 2017-03-22.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class RestaurantLoginViewController:UIViewController {
    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func goToRestaurantSignUp(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantSignUp")
        self.present(vc!, animated: true, completion: nil)
    }
    @IBAction func goToCustomerLogin(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        self.present(vc!, animated: true, completion: nil)
    }
    @IBAction func goToCustomerSignUp(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MobileHostess.SignUpViewController")
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func restaurantLogin(_ sender: Any) {
        
        if emailTextField.text == "" || passwordTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "You must enter your username and password", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {(user, error) in
                
                if error == nil {
                    print("Logged in")
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditRestaurant")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: "Incorrect username and/or password", preferredStyle: .alert)
                    
                    let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
