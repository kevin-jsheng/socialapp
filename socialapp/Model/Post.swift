//
//  Post.swift
//  socialapp
//
//  Created by Kevin Sheng on 2017-08-27.
//  Copyright © 2017 shengtech Inc. All rights reserved.
//

import Foundation

class Post {
    private var _postKey: String!
    private var _caption: String!
    private var _imageUrl: String!
    private var _likes: Int!
    
    var caption: String {
        return _caption
    }
    var imageUrl: String {
        return _imageUrl
    }
    var postKey: String {
        return _postKey
    }
    var likes: Int {
        return _likes
    }
    
    init(caption: String, imageUrl: String, likes: Int)
    {
        self._caption = caption
        self._imageUrl = imageUrl
        self._likes = likes
    }
    
    init(postKey: String, postData: Dictionary<String, Any>)
    {
        self._postKey = postKey
        if let caption = postData["caption"] as? String {
            self._caption = caption
        }
        if let imageUrl = postData["imageUrl"] as? String {
            self._imageUrl = imageUrl
        }
        if let likes = postData["likes"] as? Int {
            self._likes = likes
        }
    }
}
