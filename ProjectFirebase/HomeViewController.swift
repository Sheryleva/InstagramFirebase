////
////  HomeViewController.swift
////  ProjectFirebase
////
////  Created by Sheryl Evangelene Pulikandala on 8/5/20.
////  Copyright © 2020 Sheryl Evangelene Pulikandala. All rights reserved.
////
//
//import UIKit
//import Photos
//import Firebase
//import FirebaseDatabase
//import FirebaseStorage
//import FirebaseAuth
//import FirebaseCore
//import UIKit
//import MessageKit
//import UIKit
//import InputBarAccessoryView
//import Firebase
//import MessageKit
//import FirebaseFirestore
//import SDWebImage
//import GoogleMobileAds
//
//
//class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    
//    var post = [Post]()
//    
//    var interstitial: GADInterstitial!
//    
//    @IBOutlet weak var homeTblview: UITableView!
//    
//    var userid = Auth.auth().currentUser
//    
//    struct Storyboard {
//        static let postCell = "PostCell"
//        static let postHeaderCell = "PostHeaderCell"
//        static let postHeaderHeight: CGFloat = 57.0
//        static let postCellDefaultHeight: CGFloat = 578.0
//        
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //Ads
//        //        let st = UIStoryboard.init(name: "Main", bundle: nil)
//        //        let vc = st.instantiateViewController(identifier: "InsterstitialViewController")
//        //        self.present(vc, animated: true)
//        homeTblview.delegate = self
//        homeTblview.dataSource = self
//        self.homeTblview.register(PostCell.self, forCellReuseIdentifier: "PostCell")
//        loadData()
////        homeTblview.estimatedRowHeight = Storyboard.postCellDefaultHeight
////        homeTblview.rowHeight = UITableView.automaticDimension
//        self.homeTblview.reloadData()
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//    }
//    
//    //    override func viewWillAppear(_ animated: Bool) {
//    //        super.viewWillAppear(animated)
//    //        let fromAnimation = AnimationType.from(direction: .right, offset: 30.0)
//    //        let zoomAnimation = AnimationType.zoom(scale: 0.2)
//    //        let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
//    //        //                UIView.animate(views: tableView.visibleCells,
//    //        //                               animations: [zoomAnimation],
//    //        //                               duration: 0.3)
//    //        UIView.animate(views: view.subviews,
//    //                       animations: [zoomAnimation, rotateAnimation],
//    //                       delay: 0.3)
//    //    }
//    
//    
//    func loadData() -> [Post]  {
//        FirebaseManager.shared.getAllPosts() { (snapshot) in
//            print(snapshot.value)
//            if let dict = snapshot.value as? [String: Any] {
//                let captionText = dict["caption"] as! String
//                let PhotoUrlString = dict["PhotoURL"] as! String
//                let posts = Post(captionText: captionText, photoUrlString: PhotoUrlString)
//                self.post.append(posts)
//                print(self.post)
//                self.homeTblview.reloadData()
//                print(snapshot)
//            }
//        }
//        return self.post
//        
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(post.count)
//        return post.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: PostCell = self.homeTblview.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
//        let captionText = post[indexPath.row].caption
//        print(captionText)
//        let PhotoUrlString = post[indexPath.row].photoUrl
//        print(PhotoUrlString)
//        var storage = Storage.storage().reference(forURL: PhotoUrlString)
//        DispatchQueue.main.async {
//            storage.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
//                let image1 = UIImage(data: data!)
//                
//                // cell.userpost.image = image
//                
//                //                cell.backgroundColor = UIColor.green
////                cell.configure(image: image1!)
//                //                cell.configure(image: image1!)
//                cell.userpost?.image = image1
//                cell.postcaption?.text = "\(captionText)"
//                //        cell.fortableview = self.post[indexPath.row]
//                
//                //                cell.setNeedsLayout()
//                
//                //
//            }
//        }
//        //
//        
//        return cell 
//    }
//    
//    
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath)! as UITableViewCell
//        let image = cell.imageView?.image
//        let label = cell.textLabel?.text
//        let st = UIStoryboard.init(name: "Main", bundle: nil)
//        let vc = st.instantiateViewController(identifier: "UploadPicViewController") as! UploadPicViewController
//        vc.img = image
//        vc.label = label
//        self.present(vc, animated: true)
//    }
//    
//    
//}
//
//
//
//
