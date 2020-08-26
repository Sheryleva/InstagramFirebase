//
//  CollectionViewCell.swift
//  ProjectFirebase
//
//  Created by Sheryl Evangelene Pulikandala on 8/12/20.
//  Copyright © 2020 Sheryl Evangelene Pulikandala. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageViewPosts: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(image: UIImage) {
        imageViewPosts.image = image
    }

}
