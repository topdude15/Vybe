//
//  CustomImage.swift
//  Vybe
//
//  Created by Trevor Rose on 3/28/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit

class CustomImage: UIImageView {


    
    
    @IBInspectable
    public var cornerRadius: CGFloat = 2.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
    }
}
