//
//  CircleView.swift
//  socialapp
//
//  Created by Kevin Sheng on 2017-08-21.
//  Copyright © 2017 shengtech Inc. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width / 2
    }
     
}
