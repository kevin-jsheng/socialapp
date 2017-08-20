//
//  ViewController.swift
//  socialapp
//
//  Created by Kevin Sheng on 2017-08-02.
//  Copyright © 2017 shengtech Inc. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var passswordField: FancyField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func fbBtnTapped(_ sender: Any) {
        let fbLoginMgr = FBSDKLoginManager()
        fbLoginMgr.logIn(withReadPermissions: ["email"], from: self) {
            (result, error) in
            if error != nil {
                print ("JESS: Unable to authenticate with Facebook - \(String(describing: error))")
            } else if (result?.isCancelled == true) {
                print ("JESS: Facebook Authentication cancelled")
            } else {
                print ("JESS: Facebook Authentication Successful")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential : AuthCredential){
    
        Auth.auth().signIn(with: credential, completion: {
            (user, error) in
            if error != nil {
                print ("JESS: Unable to authenticate with Firebase - \(String(describing: error))")
            } else {
                print ("JESS: Firebase Authentication Successful")
            }
        })
    }
    
    @IBAction func signinTapped(_ sender: Any) {
        if let email = emailField.text, let password = passswordField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("JESS: Firebase Email Auth Successful")
                } else {
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("JESS: Unable to Login \(String(describing: error))")
                        } else {
                            print("JESS: Firebase Email Auth Created and Logon Successful")

                        }
                    })
                }
            })
        }}
}

