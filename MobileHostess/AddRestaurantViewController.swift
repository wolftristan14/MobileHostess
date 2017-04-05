//
//  AddRestaurantViewController.swift
//  MobileHostess
//
//  Created by Tristan Wolf on 2017-03-22.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage


class AddRestaurantViewController:UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    
    
    @IBOutlet weak var restaurantNameLabel: UITextField!
    @IBOutlet weak var restaurantAddressLabel: UITextField!
    @IBOutlet weak var partySizeLabel1: UITextField!
    @IBOutlet weak var partySizeLabel2: UITextField!
    @IBOutlet weak var partySizeLabel3: UITextField!
    @IBOutlet weak var partySizeLabel4: UITextField!
    @IBOutlet weak var partySizeLabel5: UITextField!
    @IBOutlet weak var partySizeLabel6: UITextField!
    @IBOutlet weak var partySizeLabel7: UITextField!
    @IBOutlet weak var partySizeLabel8: UITextField!
    @IBOutlet weak var partySizeLabel9: UITextField!
    @IBOutlet weak var restaurantImage: UIImageView!
    
    let picker = UIImagePickerController()
    
    var databaseRef:FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }
    
    @IBAction func choosePhotoFromLibrary(_ sender: Any) {
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated:true, completion:nil)
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        picker.sourceType = .camera
        picker.allowsEditing = false
        picker.cameraCaptureMode = .photo
        present(picker, animated:true, completion:nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        restaurantImage.contentMode = .scaleAspectFit
        restaurantImage.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: Any) {
        print("writing to database")
        let imageName = NSUUID().uuidString
        let storageRef = FIRStorage.storage().reference().child(imageName)
        
        if let uploadData = UIImagePNGRepresentation(restaurantImage.image!) {
            
            storageRef.put(uploadData, metadata: nil, completion: {(metadata, error) in
            
                if error != nil {
                    print(error?.localizedDescription ?? "error")
                    return
                }
            let imageURL = metadata?.downloadURL()?.absoluteString
                self.writeToDatabase(imageURL: imageURL!)
            })
        
        }
    }
    
    func writeToDatabase(imageURL:String) {
    
    let restaurantRef = databaseRef.child("Restaurants").child((FIRAuth.auth()?.currentUser?.uid)!)
        
        //let key = restaurantRef.key
        
        var name: String!
        if restaurantNameLabel.text != nil {
            name = self.restaurantNameLabel.text
        }
        
        var address: String!
        if restaurantAddressLabel.text != nil {
            address = self.restaurantAddressLabel.text
        }
        
        var waitTimes: [String] = []
        var waitTime:String
        
        if partySizeLabel1 != nil {
            waitTime = self.partySizeLabel1.text!
            waitTimes.append(waitTime)
        }
        if partySizeLabel2 != nil {
            waitTime = self.partySizeLabel2.text!
            waitTimes.append(waitTime)
        }
        if partySizeLabel3 != nil {
            waitTime = self.partySizeLabel3.text!
            waitTimes.append(waitTime)
        }
        if partySizeLabel4 != nil {
            waitTime = self.partySizeLabel4.text!
            waitTimes.append(waitTime)
        }
        if partySizeLabel5 != nil {
            waitTime = self.partySizeLabel5.text!
            waitTimes.append(waitTime)
        }
        if partySizeLabel6 != nil {
            waitTime = self.partySizeLabel6.text!
            waitTimes.append(waitTime)
        }
        if partySizeLabel7 != nil {
            waitTime = self.partySizeLabel7.text!
            waitTimes.append(waitTime)
        }
        if partySizeLabel8 != nil {
            waitTime = self.partySizeLabel8.text!
            waitTimes.append(waitTime)
        }
        if partySizeLabel9 != nil {
            waitTime = self.partySizeLabel9.text!
            waitTimes.append(waitTime)
        }
        
        let restaurant = Restaurant(name: name, address: address, waitTimes: waitTimes /*key: key*/, imageURL: imageURL )
        
        restaurantRef.setValue(restaurant.toAnyObject())
        
    }
}
