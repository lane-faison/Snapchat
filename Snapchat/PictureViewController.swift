//
//  PictureViewController.swift
//  Snapchat
//
//  Created by Lane Faison on 4/30/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit
import Firebase

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image
        
        imageView.backgroundColor = UIColor.clear // Gives transparent background after image is added
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        
        imagePicker.sourceType = .savedPhotosAlbum //eventually switch this back to .camera
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        
        nextButton.isEnabled = false
        
        let imagesFolder = FIRStorage.storage().reference().child("SnapchatImages")
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)! // Using this versus the PNG one allows you to shrink pictures so app runs faster
        
        
        imagesFolder.child("\(NSUUID().uuidString).jpg").put(imageData, metadata: nil, completion: {(metadata, error) in
            
            print("We tried to upload")
            
            if error != nil {
                print("We had an error: \(error)")
            } else {
                
                print(metadata?.downloadURL())
                
                self.performSegue(withIdentifier: "selectUserSegue", sender: metadata?.downloadURL()!.absoluteString)

            }
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nextVC = segue.destination as! SelectUserViewController
        nextVC.imageURL = sender as! String
        nextVC.descrip = descriptionTextField.text!
        
        
    }
}
