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
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var partySizesTextView: UITextView!
    
    let picker = UIImagePickerController()
    var waitTimes:[String: AnyObject] = [:]

    
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
        
        if let uploadData = UIImagePNGRepresentation(restaurantImage.image ?? #imageLiteral(resourceName: "Tom's_Restaurant,_NYC")) {
            
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
    
    
    @IBAction func addPartySize(_ sender: Any) {
        var waitTime:String?

        if partySizeLabel1 != nil && partySizeLabel1.text != "" {
            waitTime = self.partySizeLabel1.text!
            waitTimes.updateValue("0" as AnyObject, forKey: waitTime!)
            
        }
        var valuesArray = Array(self.waitTimes.keys)
        valuesArray.sort {$0 < $1}
        let cleanValuesArray = valuesArray.description.trimmingCharacters(in: .init(charactersIn: "[]"))
        partySizesTextView.text = cleanValuesArray
        
        partySizeLabel1.text?.removeAll()
        self.reloadInputViews()
    }
    
    func writeToDatabase(imageURL:String) {
    
    let restaurantRef = databaseRef.child("Restaurants").child((FIRAuth.auth()?.currentUser?.uid)!)
        
        let key = databaseRef.child("Restaurants").key
        
        var name: String!
        if restaurantNameLabel.text != nil {
            name = self.restaurantNameLabel.text
        }
        
        var address: String!
        if restaurantAddressLabel.text != nil {
            address = self.restaurantAddressLabel.text
        }
        
        let currentTimeTimeStamp = Date.init(timeIntervalSinceNow: -7200)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timeStamp = dateFormatter.string(from: currentTimeTimeStamp)
  
        
        let restaurant = Restaurant(name: name, address: address, waitTimes: waitTimes, key: key, imageURL: imageURL, uuid: (FIRAuth.auth()?.currentUser?.uid)!, timeSinceLastUpdate: timeStamp)
        
        restaurantRef.setValue(restaurant.toAnyObject())
        
        presentEditRestaurantVC()
        
    }
    
    func presentEditRestaurantVC() {
        performSegue(withIdentifier: "EditRestaurant", sender: self)
    }
}
