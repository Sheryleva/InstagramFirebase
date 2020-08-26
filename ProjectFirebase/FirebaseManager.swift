//
//  FirebaseManager.swift
//  iGram
//
//  Created by Milan Chalishajarwala on 8/11/20.
//  Copyright © 2020 Milan Chalishajarwala. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

typealias CompletionHandler = ((DataSnapshot) -> ())?
var user = Auth.auth().currentUser?.uid

class FirebaseManager{
    static let shared = FirebaseManager()
    var photoIdString = NSUUID().uuidString
    
    private init(){}
    
    func getAllPosts( completionHandler: CompletionHandler){
        
        Database.database().reference().child("posts").observe(.childAdded){ (snapshot) in
            completionHandler?(snapshot)
            
            
        }
    }
    
    func getUsersPosts(completionHandler: CompletionHandler){
        
        Database.database().reference().child("Users").child(user!).child("posts").observe(.childAdded){ (snapshot) in
            completionHandler?(snapshot)
            
            
        }
        
    }
    
    func getUsernames(completionHandler: CompletionHandler){
        
        Database.database().reference().child("Users").observe(.childAdded){ (snapshot) in
            completionHandler?(snapshot)
            
            
        }
        
    }
    
}

