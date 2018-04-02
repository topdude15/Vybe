//
//  SignUpEmail.swift
//  Vybe
//
//  Created by Trevor Rose on 3/31/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit
import Material

class SignUpEmail: UIViewController {

    @IBOutlet weak var emailBox: ErrorTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func continueTapped(_ sender: Any) {
        let email = emailBox.text
        Util.ds.userInfo.updateValue(email as AnyObject, forKey: "email")
        let password = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpPassword")
        self.present(password, animated: true, completion: nil)
    }
}
