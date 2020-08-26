//
//  ImageUploadViewController.swift
//  ProjectFirebase
//
//  Created by Sheryl Evangelene Pulikandala on 8/9/20.
//  Copyright © 2020 Sheryl Evangelene Pulikandala. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import Photos
import UIKit
import Firebase

class ImageUploadViewController: UIViewController{
    
    @IBOutlet weak var uploadpic: UIImageView!
    
    var username = [Post1]()
    
    @IBOutlet weak var sharebutton: UIButton!
    @IBOutlet weak var caption: UITextView!
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfilephoto()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ImageUploadViewController.handleSelectPhoto))
        uploadpic.addGestureRecognizer(tapGesture)
        uploadpic.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        if selectedImage != nil {
        //            self.sharebutton.isEnabled = true
        self.sharebutton.backgroundColor = .blue
        //        }else {
        //            self.sharebutton.isEnabled = false
        //            self.sharebutton.backgroundColor = .lightGray
        //        }
    }
    
    func getProfilephoto() -> [Post1] {
        let user = Auth.auth().currentUser?.uid
        print(user)
        Database.database().reference().child("Users").child(user!).observeSingleEvent(of: .value){ (snapshot) in
            print(snapshot.value)
            if let dict = snapshot.value as? NSDictionary {
                let user = dict["Username"] as? String ?? ""
                let email = dict["email"] as? String ?? ""
                let profilepic = dict["profile_photo"] as? String ?? ""
                let User = Post1(user: user, emailid: email, pic: profilepic)
                self.username.append(User)
                
            }
        }
        return self.username
    }
    
    @objc func handleSelectPhoto() {
        let pickController = UIImagePickerController()
        pickController.delegate = self
        pickController.allowsEditing = true
        present(pickController, animated: true, completion: nil)
    }
    @IBAction func uploadImage(_ sender: Any) {
        let user = Auth.auth().currentUser!
        let uid = user.uid
        let photoIdString = NSUUID().uuidString
        let storageRef = Storage.storage().reference(forURL: "gs://b24sheryl.appspot.com").child("posts").child(photoIdString)
        let imageData = (self.selectedImage)?.jpegData( compressionQuality: 0.1)
        
        storageRef.putData(imageData!, metadata: nil)
        {
            (metadata, error) in
            if error != nil {
                return
            }
            
            let URL = "gs://b24sheryl.appspot.com"
            let photoUrl =  "\(URL)/\(metadata?.path ?? "")"
            let ref = Database.database().reference()
            let postsReference = ref.child("posts")
            let newPostId = postsReference.childByAutoId().key
            let newUserReference = postsReference.child(newPostId!)
            ref.child("Users").child(uid).child("posts").child(newPostId!).setValue(["PhotoURL": photoUrl, "caption": self.caption.text as String]) { (error, ref) in
                
                print("Success")
                self.caption.text = "Write caption here..."
                self.uploadpic.image = UIImage(named: "ic_account_circle.png")
                self.selectedImage = nil
                self.tabBarController?.selectedIndex = 0
            }
            newUserReference.setValue(["PhotoURL": photoUrl, "caption": self.caption.text as String,"Username": self.username[0].Username, "profile_photo": self.username[0].profilepic]) { (error, ref) in
                
                print("Success")
                self.caption.text = "Write caption here..."
                self.uploadpic.image = UIImage(named: "ic_account_circle.png")
                self.selectedImage = nil
                self.tabBarController?.selectedIndex = 0
            }
            
        }
    }
}

extension ImageUploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.allowsEditing = true
        if let img = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")]
            as? UIImage {
            selectedImage = img
            uploadpic.image = img
        }
        dismiss(animated: true, completion: nil)
        
    }
    
}
