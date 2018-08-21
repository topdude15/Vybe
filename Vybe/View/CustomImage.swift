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
    
//    public var borderColor: UIColor? = UIColor.white {
//        didSet {
//            self.layer.borderColor = self.borderColor?.cgColor
//        }
//    }
//    
//    public var borderWidth: CGFloat = 2.0 {
//        didSet {
//            self.layer.borderWidth = self.borderWidth
//        }
//    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        //self.layer.borderColor = UIColor.white.cgColor
        //self.layer.borderWidth = 2
    }
}
