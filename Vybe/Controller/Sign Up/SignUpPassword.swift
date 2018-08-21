//
//  SignUpPassword.swift
//  Vybe
//
//  Created by Trevor Rose on 3/31/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit
import Material
import Firebase

class SignUpPassword: UIViewController {

    @IBOutlet weak var passwordField: ErrorTextField!
    @IBOutlet weak var repeatPasswordField: ErrorTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func finishSignUp(_ sender: Any) {
        let password = passwordField.text, repeatPassword = repeatPasswordField.text
        if password == repeatPassword {
            let email = Util.ds.userInfo["email"]
            Auth.auth().createUser(withEmail: email as! String, password: password!) { (user, error) in
                if error != nil {
                    print("Could not create user")
                } else {
                    let uid = user?.user.uid
                    Database.database().reference().child("users").child(uid!).updateChildValues(Util.ds.userInfo)
                    Database.database().reference().child("usernames").updateChildValues([Util.ds.userInfo["username"] as! AnyHashable: uid!])
                    let main = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainPageVC")
                    self.present(main, animated: true, completion: nil)
                }
            }
        }
    }
}
