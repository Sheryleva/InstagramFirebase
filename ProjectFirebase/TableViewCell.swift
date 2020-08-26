//
//  TableViewCell.swift
//  ProjectFirebase
//
//  Created by Sheryl Evangelene Pulikandala on 8/13/20.
//  Copyright © 2020 Sheryl Evangelene Pulikandala. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var profilepic: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var postimage: UIImageView!
    
    @IBOutlet weak var like: UIButton!
    
    @IBOutlet weak var comment: UIButton!
    
    @IBOutlet weak var NoLikes: UILabel!
    
    @IBOutlet weak var caption: UILabel!
    
    @IBOutlet weak var timeago: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
