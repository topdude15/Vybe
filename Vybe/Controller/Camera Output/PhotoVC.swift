//
//  PhotoVC.swift
//  Vybe
//
//  Created by Trevor Rose on 4/10/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit
import Firebase

class PhotoVC: UIViewController {
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
        view.addSubview(backgroundImageView)
        
        let sendButton = UIButton(frame: CGRect(x: (self.view.frame.width - 50), y: (self.view.frame.height - 50), width: 30.0, height: 30.0))
        sendButton.setImage(#imageLiteral(resourceName: "cancel"), for: UIControlState())
        //cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        view.addSubview(sendButton)
    }
    func sendImage() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
