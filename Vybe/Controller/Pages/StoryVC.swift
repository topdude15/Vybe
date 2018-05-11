//
//  StoryVC.swift
//  Vybe
//
//  Created by Trevor Rose on 4/26/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit
import Firebase

class StoryVC: UIViewController {
    
    var friendsList: Array = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("friendships").child(uid!).observeSingleEvent(of: .value) { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if (snap.value as! Int == 2) {
                        self.friendsList.append(snap.key)
                        
                    }
                }
            }
            print(self.friendsList)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

