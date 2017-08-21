//
//  FeedVC.swift
//  socialapp
//
//  Created by Kevin Sheng on 2017-08-20.
//  Copyright © 2017 shengtech Inc. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func signOut(_ sender: Any) {
        
        let removeSuccessful: Bool = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        if (removeSuccessful)
        {
            print ("JESS: Key chain removed successfully")
        }
        else
        {
            print ("JESS: Key chain removed Failed")
        }
        
        try! Auth.auth().signOut()
       
        
        performSegue(withIdentifier: "LoginVC", sender: nil)
    }
}
