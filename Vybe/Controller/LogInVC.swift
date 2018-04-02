//
//  LogInVC.swift
//  Vybe
//
//  Created by Trevor Rose on 3/31/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit
import Material
import Firebase

class LogInVC: UIViewController {

    @IBOutlet weak var emailBox: ErrorTextField!
    @IBOutlet weak var passwordBox: ErrorTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signIn(_ sender: Any) {
        let email = emailBox.text
        let password = passwordBox.text
        Auth.auth().signIn(withEmail: email!, password: password!) { (user, error) in
            if error != nil {
                print("Error signing in")
            } else {
                let main = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainPageVC")
                self.present(main, animated: true, completion: nil)
            }
        }
    }
}
