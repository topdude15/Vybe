//
//  ViewPhotoVC.swift
//  Vybe
//
//  Created by Trevor Rose on 4/11/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit

class ViewPhotoVC: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    private var backgroundImage: UIImage
    
    init(image: UIImage) {
        self.backgroundImage = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImageView = UIImageView(frame: view.frame)
        backgroundImageView.contentMode = UIViewContentMode.scaleAspectFit
        backgroundImageView.image = backgroundImage
        backgroundImageView.isUserInteractionEnabled = true
        view.addSubview(backgroundImageView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        tap.numberOfTapsRequired = 1
        tap.delegate = self as? UIGestureRecognizerDelegate
        backgroundImageView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
