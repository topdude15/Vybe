//
//  CaptureVC.swift
//  Vybe
//
//  Created by Trevor Rose on 2/25/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit
import Firebase

class CaptureVC: SwiftyCamViewController, SwiftyCamViewControllerDelegate {

   // @IBOutlet weak var captureButton: SwiftyCamButton!
    @IBOutlet weak var flipCameraButton: UIButton!
    @IBOutlet weak var flashButton: UIButton!
    @IBOutlet weak var captureButton: SwiftyRecordButton!
    @IBOutlet weak var storyImage: CustomImage!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        print("Hereasdf")
        super.viewDidLoad()
        swipeToZoomInverted = false
        pinchToZoom = true
        swipeToZoom = false
        cameraDelegate = self
        maximumVideoDuration = 10.0
        shouldUseDeviceOrientation = true
        allowAutoRotate = true
        audioEnabled = true
        allowBackgroundAudio = true
        if Auth.auth().currentUser == nil {
            let frontPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FrontPageVC")
            self.present(frontPage, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureButton.delegate = self
    }
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
        let photo = PhotoVC(image: photo)
        self.present(photo, animated: true, completion: nil)
    }
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didBeginRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        print("Yup")
        captureButton.growButton()
        UIView.animate(withDuration: 0.25) {
            self.flashButton.alpha = 0.0
            self.flipCameraButton.alpha = 0.0
            self.storyImage.alpha = 0.0
            self.searchBar.alpha = 0.0
        }
    }
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        print("Done!")
        captureButton.shrinkButton()
        UIView.animate(withDuration: 0.25) {
            self.flashButton.alpha = 1.0
            self.flipCameraButton.alpha = 1.0
            self.storyImage.alpha = 1.0
            self.searchBar.alpha = 1.0
        }
    }
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishProcessVideoAt url: URL) {
        print("Here")
        let video = VideoVC(videoURL: url)
        self.present(video, animated: true, completion: nil)
    }
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFailToRecordVideo error: Error) {
        print("Here is the error: \(error)")
    }
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFocusAtPoint point: CGPoint) {
        let focusView = UIImageView(image: #imageLiteral(resourceName: "focus"))
        focusView.center = point
        focusView.alpha = 0.0
        view.addSubview(focusView)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            focusView.alpha = 1.0
            focusView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }, completion: { (success) in
            UIView.animate(withDuration: 0.15, delay: 0.5, options: .curveEaseInOut, animations: {
                focusView.alpha = 0.0
                focusView.transform = CGAffineTransform(translationX: 0.6, y: 0.6)
            }, completion: { (success) in
                focusView.removeFromSuperview()
            })
        })
    }
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didChangeZoomLevel zoom: CGFloat) {
        //
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cameraSwitchTapped(_ sender: Any) {
        switchCamera()
    }
    @IBAction func toggleFlashTapped(_ sender: Any) {
        
    }

    @IBAction func tapStoryImage(_ sender: Any) {
        let friend = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddFriendVC")
        self.present(friend, animated: true, completion: nil)
    }
}
