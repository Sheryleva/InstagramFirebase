//
//  DemoViewController.swift
//  ProjectFirebase
//
//  Created by Sheryl Evangelene Pulikandala on 8/13/20.
//  Copyright © 2020 Sheryl Evangelene Pulikandala. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class DemoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var post = [Post]()
    @IBOutlet weak var table: UITableView!
    var imageView: UIImage!
    var captionText: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        table.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        loadData()
        self.table.reloadData()
        
    }
    
    func loadData() -> [Post]  {
        FirebaseManager.shared.getAllPosts() { (snapshot) in
            print(snapshot.value)
            if let dict = snapshot.value as? [String: Any] {
                let captionText = dict["caption"] as! String
                let PhotoUrlString = dict["PhotoURL"] as! String
                let profilepic = dict["profile_photo"] as! String
                let Username = dict["Username"] as! String
                let posts = Post(captionText: captionText, photoUrlString: PhotoUrlString, user: Username, pic: profilepic)
                self.post.append(posts)
                print(self.post)
                self.table.reloadData()
                print(snapshot)
            }
        }
        return self.post
        
    }
    
    
    
    func getDate() ->String {
        let date = Date()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM dd yyyy"
        let result = dateFormat.string(from: date)
        return result
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(post.count)
        return post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.table.dequeueReusableCell(withIdentifier: "NewCell") as! TableViewCell
        captionText = post[indexPath.row].caption
        print(captionText)
        let PhotoUrlString = post[indexPath.row].photoUrl
        print(PhotoUrlString)
        let profilepic = post[indexPath.row].profilepic
        let user = post[indexPath.row].Username
        let storage = Storage.storage().reference(forURL: PhotoUrlString)
        let storage1 = Storage.storage().reference(forURL: profilepic)
        storage.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
            let image2 = UIImage(data: data!)
            cell.profilepic.image = image2
           
        }
        DispatchQueue.main.async {
            storage.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
                let image1 = UIImage(data: data!)
                cell.postimage.image = image1
                cell.caption.text = "\(self.captionText)"
                 cell.username.text = "\(user)"
            }
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(identifier: "UploadPicViewController") as! UploadPicViewController
        vc.img = cell.postimage.image
        vc.label = cell.caption.text
        self.present(vc, animated: true)
    }
    
    
    
    
}
