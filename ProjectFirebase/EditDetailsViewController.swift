//
//  EditDetailsViewController.swift
//  ProjectFirebase
//
//  Created by Sheryl Evangelene Pulikandala on 8/6/20.
//  Copyright © 2020 Sheryl Evangelene Pulikandala. All rights reserved.
//

import UIKit

class EditDetailsViewController: UIViewController {

    
    @IBOutlet weak var save_details: UIButton!
    
    @IBOutlet weak var name: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        save_details.backgroundColor = UIColor.blue
      
    }
    
    @IBAction func saveDetails(_ sender: UIButton) {
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(identifier: "UserProfileViewController")
        navigationController?.popViewController(animated: true)
    }
    
}
