//
//  UserProfileViewController.swift
//  ProjectFirebase
//
//  Created by Sheryl Evangelene Pulikandala on 8/8/20.
//  Copyright © 2020 Sheryl Evangelene Pulikandala. All rights reserved.
//


import UIKit
import Firebase
import GoogleSignIn
import SDWebImage
import FirebaseAuth
import FirebaseDatabase
import  FirebaseStorage
import GoogleMobileAds


class UserProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, GADInterstitialDelegate {
    
    
    @IBOutlet weak var Collectionview: UICollectionView!
    var post = [Post2]()
    var profile = [Post1]()
    private let itemsPerRow: CGFloat = 3
    var username: String = ""
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var Collectionimageview: UIImageView!
    
    private let reuseIdentifier = "CollectionCell"
    
    @IBOutlet weak var namelabel: UILabel!
    
    @IBOutlet weak var tblView: UITableView!
    
    var interstitial: GADInterstitial!
    
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        
        getProfilephoto()
        print(username)
        
        Collectionview.delegate = self
        Collectionview.dataSource = self
        self.Collectionview.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        loadData()
        navigationController?.title = Auth.auth().currentUser?.displayName
        Database.database().reference().child("Users").child(user!).child("Username").observeSingleEvent(of: .value){ (snapshot) in
            let user = snapshot.value
            print(user)
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationItem.title = self.username
    }
    
    func loadData( )-> [Post2] {
        FirebaseManager.shared.getUsersPosts() { (snapshot) in
            print(snapshot.value)
            if let dict = snapshot.value as? [String: Any] {
                let captionText = dict["caption"] as! String
                let PhotoUrlString = dict["PhotoURL"] as! String
                let posts = Post2(captionText: captionText, photoUrlString: PhotoUrlString)
                self.post.append(posts)
                print(self.post)
                self.Collectionview.reloadData()
            }
        }
        return post
    }
    
    func getProfilephoto( ) {
        let user = Auth.auth().currentUser?.uid
        print(user)
        Database.database().reference().child("Users").child(user!).observeSingleEvent(of: .value){ (snapshot) in
            print(snapshot.value)
            let dict = snapshot.value as? NSDictionary
            let user = dict!["Username"] as? String ?? ""
            self.namelabel.text = user.uppercased()
            print(self.username)
            
            let email = dict!["email"] as? String ?? ""
            let profilepic = dict!["profile_photo"] as? String ?? ""
            let storage = Storage.storage().reference(forURL: profilepic)
            DispatchQueue.main.async {
                
                storage.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
                    let image = UIImage(data: data!)
                    self.imageView.image = image
                }
            }
            
            
        }
    }
 
    @IBAction func displayAd(_ sender: UIButton) {
        if interstitial.isReady {
          interstitial.present(fromRootViewController: self)
        }
    }
    
    
    
    
    
    @IBAction func editProfile(_ sender: UIButton) {
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(identifier: "EditDetailsViewController")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    @IBAction func barbuttonclicked(_ sender: UIBarButtonItem) {
        moreAlert.popoverPresentationController?.barButtonItem = sender
        present(moreAlert, animated: true, completion: nil)
    }
    
    
    lazy var moreAlert: UIAlertController = {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Sign out", style: .default , handler:{ (UIAlertAction)in
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                let st = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = st.instantiateViewController(identifier: "LoginViewController")
                self.navigationController?.pushViewController(vc, animated: true)
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }))
        alert.addAction(UIAlertAction(title: "Delete account", style: .destructive , handler:{ _ in
            let user = Auth.auth().currentUser
            
            user?.delete { error in
                if let error = error {
                    print("Error deleting your account! Try again later.")
                } else {
                    print("Your account has been deleted. We are sorry to see you go!")
                    let st = UIStoryboard.init(name: "Main", bundle: nil)
                    let vc = st.instantiateViewController(identifier: "LoginViewController")
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: nil))
        return alert
    }()
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(post.count)
        return post.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        let captionText = post[indexPath.row].caption
        let PhotoUrlString = post[indexPath.row].photoUrl
        let storage = Storage.storage().reference(forURL: PhotoUrlString)
        DispatchQueue.main.async {
            storage.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
                let image = UIImage(data: data!)
                
                cell.imageViewPosts.image = image
                //                                cell.userpost.image = image
                
            }
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(identifier: "UploadPicViewController") as! UploadPicViewController
        vc.img = cell.imageViewPosts.image
//        vc.label = cell.captio
        self.present(vc, animated: true)
    }
}

extension UserProfileViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

