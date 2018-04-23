//
//  MainPageVC.swift
//  Vybe
//
//  Created by Trevor Rose on 2/25/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit

class MainPageVC: UIViewController {
    
    @IBOutlet weak var scroll: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let left = self.storyboard?.instantiateViewController(withIdentifier: "ChatNav") as! UINavigationController
        self.addChildViewController(left)
        self.scroll.addSubview(left.view)
        self.didMove(toParentViewController: self)
        
        let middle = self.storyboard?.instantiateViewController(withIdentifier: "CaptureVC") as! CaptureVC
        self.addChildViewController(middle)
        self.scroll.addSubview(middle.view)
        self.didMove(toParentViewController: self)
        
        var middleFrame: CGRect = middle.view.frame
        middleFrame.origin.x = self.view.frame.width
        middle.view.frame = middleFrame
        
        let right = self.storyboard?.instantiateViewController(withIdentifier: "RightVC") as! RightVC
        self.addChildViewController(right)
        self.scroll.addSubview(right.view)
        self.didMove(toParentViewController: self)
        
        var rightFrame: CGRect = right.view.frame
        rightFrame.origin.x = 2 * self.view.frame.width
        right.view.frame = rightFrame
        
        scroll.contentOffset = CGPoint(x: self.view.frame.width, y: 0)
        self.scroll.contentSize = CGSize(width: (self.view.frame.width) * 3, height: self.view.frame.height)
    }
}
