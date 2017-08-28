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

class FeedVC: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        //  this will execute whenever data change in the server
        //  it also execute when this run initially
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            //  print (snapshot.value)
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot  {
                    print ("SNAP \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, Any> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // print ("JESS: Load tableview")
        let post = posts[indexPath.row]
        
        // print ("JESS: Post \(post.caption)")
        
        return tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as! PostTableViewCell
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
