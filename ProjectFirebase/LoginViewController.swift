//
//  LoginViewController.swift
//  ProjectFirebase
//
//  Created by Sheryl Evangelene Pulikandala on 8/5/20.
//  Copyright © 2020 Sheryl Evangelene Pulikandala. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth

class LoginViewController: UIViewController, GIDSignInDelegate {
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var instagram: UILabel!
    
    @IBOutlet weak var login: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        
        //        instagram.font =  UIFont(name: "Bodoni 72 Oldstyle-Bold ", size: 40)
        login.backgroundColor = UIColor.blue
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let auth = user.authentication else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        Auth.auth().signIn(with: credentials) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Login Successful")
                self.openHomeViewController()
            }
            
        }
        
        
    }
    
    
    @IBAction func newuser(_ sender: UIButton) {
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(identifier: "SignupViewController")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func login(_ sender: UIButton) {
        
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { [weak self] authResult, error in
            if error == nil {
                self!.openHomeViewController()
            }
            else {print("Login Failed.")}
        }
        
    }
    
    
    func openHomeViewController() {
        
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(identifier: "TabBarController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
