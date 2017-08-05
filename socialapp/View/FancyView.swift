//
//  FancyView.swift
//  socialapp
//
//  Created by Kevin Sheng on 2017-08-04.
//  Copyright © 2017 shengtech Inc. All rights reserved.
//

import UIKit

class FancyView: UIView {
    // Create a shadow border
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
}
