//
//  Post.swift
//  ProjectFirebase
//
//  Created by Sheryl Evangelene Pulikandala on 8/11/20.
//  Copyright © 2020 Sheryl Evangelene Pulikandala. All rights reserved.
//

import Foundation
import UIKit
class Post {
    var caption: String
    var photoUrl: String
    var Username: String
    var profilepic: String
    
    
    
    init(captionText: String, photoUrlString: String, user: String, pic: String ) {
        caption = captionText
        photoUrl = photoUrlString
        Username = user
        profilepic = pic
        
        
    }
}


class Post1{
    var Username: String
    var email: String
    var profilepic: String
    
    init(user: String, emailid: String, pic: String ) {
        Username = user
        email = emailid
        profilepic = pic
        
    }
}

class Post2{
    var caption: String
    var photoUrl: String
    
    init(captionText: String, photoUrlString: String ) {
        caption = captionText
        photoUrl = photoUrlString
        
    }
}
    
    class Users{
     var Username: String
    
    init(user: String ) {
        Username = user
        
    }
    }
    


