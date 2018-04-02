//
//  SignUpUsername.swift
//  Vybe
//
//  Created by Trevor Rose on 3/31/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit
import Material
import Firebase

class SignUpUsername: UIViewController {

    @IBOutlet weak var usernameBox: ErrorTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continueTapped(_ sender: Any) {
       let username = usernameBox.text
        
        Database.database().reference().child("usernames").observeSingleEvent(of: .value) { (snapshot) in
        if snapshot.hasChild(username!) {
            print("Username is already in use")
        } else {
            Util.ds.userInfo.updateValue(username as AnyObject, forKey: "username")
            let email = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpEmail")
            self.present(email, animated: true, completion: nil)
            }
        }
    }
    
}
