//
//  PostTableViewCell.swift
//  socialapp
//
//  Created by Kevin Sheng on 2017-08-21.
//  Copyright © 2017 shengtech Inc. All rights reserved.
//

import UIKit

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
    
    func configCell(post: Post)
    {
        self.post = post
        self.captionTxtView.text = post.caption
        self.likesLbl.text = "\(post.likes)"
        
        
    }

}
