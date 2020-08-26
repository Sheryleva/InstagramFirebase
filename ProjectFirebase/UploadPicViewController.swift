//
//  UploadPicViewController.swift
//  ProjectFirebase
//
//  Created by Sheryl Evangelene Pulikandala on 8/5/20.
//  Copyright © 2020 Sheryl Evangelene Pulikandala. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class UploadPicViewController: UIViewController {

    var img: UIImage?
    var label: String?
    @IBOutlet weak var labelinview: UILabel!
    
    @IBOutlet weak var imageview: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageview.image = img
        self.labelinview.text = label
        
        }

    
}
