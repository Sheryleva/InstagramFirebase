//
//  SignupViewController.swift
//  ProjectFirebase
//
//  Created by Sheryl Evangelene Pulikandala on 8/10/20.
//  Copyright © 2020 Sheryl Evangelene Pulikandala. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import GoogleMobileAds

class SignupViewController: UIViewController, GADBannerViewDelegate {
    @IBOutlet weak var imageviewSignup: UIImageView!
    
     var bannerView: GADBannerView!
    
    var selectedImage : UIImage?
    
    var user: User! = nil
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var signup: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        imageviewSignup.layer.cornerRadius = 40
        imageviewSignup.clipsToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignupViewController.handleSelectProfileImageView))
        imageviewSignup.addGestureRecognizer(tapGesture)
        imageviewSignup.isUserInteractionEnabled = true
        signup.backgroundColor = UIColor.blue
        bannerView = GADBannerView(adSize:kGADAdSizeLargeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
               bannerView.rootViewController = self
               bannerView.load(GADRequest())
               bannerView.delegate = self
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
      // Add banner to view and add constraints as above.
      addBannerViewToView(bannerView)
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
        ])
    }
    
    @objc func handleSelectProfileImageView() {
        let pickController = UIImagePickerController()
        pickController.delegate = self
        present(pickController, animated: true, completion: nil)
    }
    
    
    @IBAction func signup(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { authResult, error in
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            }
                
            else {
                print("User Created")
                //
            }
            self.user = Auth.auth().currentUser!
            let uid = self.user.uid
            let storageRef = Storage.storage().reference(forURL: "gs://b24sheryl.appspot.com").child("profile_photos").child(uid)
            let imageviewSignup = self.selectedImage
            let imageData = (self.selectedImage)?.jpegData( compressionQuality: 0.1)
            storageRef.putData(imageData!, metadata: nil)
            {
                (metadata, error) in
                if error != nil {
                    return
                }
                let URL = "gs://b24sheryl.appspot.com"
                let profileImageUrl =  "\(URL)/\(metadata?.path ?? "")"
                let ref = Database.database().reference()
                let usersReference = ref.child("Users")
                //            print(usersReference.description())
                
                let newUserReference = usersReference.child(uid)
                newUserReference.setValue(["Username": self.username.text! as String, "email": self.email.text! as String, "profile_photo": profileImageUrl])
                //
                print("Description of New User: \(newUserReference.description())")
            }
            
            
        }
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(identifier: "TabBarController")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}


extension SignupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            imageviewSignup.image = img
            selectedImage = img
        }
        dismiss(animated: true, completion: nil)
        
    }
    
}
