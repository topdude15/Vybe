//
//  CustomView.swift
//  Vybe
//
//  Created by Trevor Rose on 3/28/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit

class CustomView: UIView {

    @IBInspectable
    public var cornerRadius: CGFloat = 2.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
}
