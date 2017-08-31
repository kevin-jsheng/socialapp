//
//  PostTableViewCell.swift
//  socialapp
//
//  Created by Kevin Sheng on 2017-08-21.
//  Copyright © 2017 shengtech Inc. All rights reserved.
//

import UIKit
import Firebase

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var captionTxtView: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    
    var post : Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(post: Post, img: UIImage? = nil)
    {
        self.post = post
        self.captionTxtView.text = post.caption
        self.likesLbl.text = "\(post.likes)"
        
        if img != nil {
            self.postImg.image = img
        } else {
           
            let ref = Storage.storage().reference(forURL: post.imageUrl)
            ref.getData(maxSize: 10 * 1024 * 1024, completion: {
                (data, error ) in
                if error != nil {
                    print ("JESS: unable to download image from firebase storage")
                } else {
                    print ("JESS: image downloaded from firebase storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postImg.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                        }
                    }
                }
                
            })
        
        }
        
        
    }

}
