//
//  VideoVC.swift
//  Vybe
//
//  Created by Trevor Rose on 4/10/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit
import Foundation
import AVKit

class VideoVC: UIViewController {

    private var videoURL: URL
    var player: AVPlayer?
    var playerController: AVPlayerViewController?
    
    override func viewDidLoad() {
        print("New controller")
        super.viewDidLoad()

        player = AVPlayer(url: videoURL)
        playerController = AVPlayerViewController()
        
        guard player != nil && playerController != nil else {
            return
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    init(videoURL: URL) {
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
