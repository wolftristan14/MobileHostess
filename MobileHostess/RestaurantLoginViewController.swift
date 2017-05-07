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
   
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RestaurantSignUp" {
            let restaurantSignUpViewController:RestaurantSignUpViewController = segue.destination as! RestaurantSignUpViewController
        }
    }
    @IBAction func prepareToUnwindToRestaurantLoginVC(segue:UIStoryboardSegue) {
        emailTextField.text?.removeAll()
        passwordTextField.text?.removeAll()
        
        if FIRAuth.auth()?.currentUser != nil {
            let firebaseAuth = FIRAuth.auth()
            do {
                try firebaseAuth?.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError.localizedDescription)
            }
        }
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
                    
                    self.segue()
                    
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: "Incorrect username and/or password", preferredStyle: .alert)
                    
                    let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func segue() {
        performSegue(withIdentifier: "restaurantlogin/editrestaurant", sender: self)

    }
    
}
