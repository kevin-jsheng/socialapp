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

class FeedVC: UIViewController , UITableViewDelegate , UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageAdded: CircleView!
    @IBOutlet weak var captionField: FancyField!
    
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    var imageSelected = false
    
    static var imageCache: NSCache <NSString, UIImage> = NSCache()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageAdded.image = image
            imageSelected = true
        } else {
            print ("JESS: no valid image selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
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
    
    @IBAction func postBtnTapped(_ sender: Any) {
        
        guard let caption = captionField.text, caption != "" else {
            print("JESS: Caption field is nil")
            return
        }
        
        guard let img  = imageAdded.image, imageSelected == true else {
            print("JESS: image field is nil")
            return
        }
        
        if let imageData = UIImageJPEGRepresentation(img, 0.2) {
            
            let imageUid = NSUUID().uuidString
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            DataService.ds.REF_POST_IMAGES.child(imageUid).putData(imageData, metadata: metadata) { (metadata, error) in
                if error != nil {
                    print ("JESS: Unable to upload image to Storage")
                } else {
                    print ("JESS: Uploaded image to Storage OK")
                    let downloadUrl = metadata?.downloadURL()?.absoluteString
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // print ("JESS: Load tableview")
        
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as? PostTableViewCell {
            
            //  var img: UIImage
            if let img = FeedVC.imageCache.object(forKey: post.imageUrl as NSString) {
                cell.configCell(post: post, img: img)
            } else {
                cell.configCell(post: post)
            }
            return cell
        } else {
            return PostTableViewCell()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addImageTapped(_ sender: Any) {
        
        present(imagePicker, animated: true, completion: nil)
    }
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
