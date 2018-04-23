//
//  CustomChatCell.swift
//  Vybe
//
//  Created by Trevor Rose on 4/22/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit

class CustomChatCell: UIView {

    @IBInspectable
    public var cornerRadius: CGFloat = 2.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.shadowColor = UIColor(red:0.93, green:0.95, blue:0.98, alpha:1.0).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 2
    }

}
