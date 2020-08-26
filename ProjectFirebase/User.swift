//
//  User.swift
//  ProjectFirebase
//
//  Created by Sheryl Evangelene Pulikandala on 8/10/20.
//  Copyright © 2020 Sheryl Evangelene Pulikandala. All rights reserved.
//

import Firebase
import FirebaseDatabase
import FirebaseAuth

class FPUser {
    var uid: String
    var fullname: String
    var profilePictureURL: URL?
    var uniqueid: String
    
    init(snapshot: DataSnapshot) {
        self.uid = snapshot.key
        let value = snapshot.value as! [String: Any]
        self.fullname = value["full_name"] as? String ?? ""
        self.uniqueid = value["user email"] as? String ?? ""
        guard let profile_picture = value["profile_picture"] as? String,
            let profilePictureURL = URL(string: profile_picture) else { return }
        self.profilePictureURL = profilePictureURL
    }
    
    init(dictionary: [String: String]) {
        self.uid = dictionary["uid"]!
        self.fullname = dictionary["full_name"] ?? ""
        self.uniqueid = dictionary["user email"] ?? ""
        guard let profile_picture = dictionary["profile_picture"],
            let profilePictureURL = URL(string: profile_picture) else { return }
        self.profilePictureURL = profilePictureURL
    }
    
    private init(user: User) {
        self.uid = user.uid
        self.fullname = user.displayName ?? ""
        self.profilePictureURL = user.photoURL
        self.uniqueid = user.email ?? ""
    }
    
    static func currentUser() -> FPUser {
        return FPUser(user: Auth.auth().currentUser!)
    }
    
    func author() -> [String: String] {
        return ["uid": uid, "full_name": fullname, "profile_picture": profilePictureURL?.absoluteString ?? "", "user email": uniqueid]
    }
}

extension FPUser: Equatable {
    static func ==(lhs: FPUser, rhs: FPUser) -> Bool {
        return lhs.uid == rhs.uid
    }
    static func ==(lhs: FPUser, rhs: User) -> Bool {
        return lhs.uid == rhs.uid
    }
}

