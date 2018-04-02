//
//  FrontPageVC.swift
//  Vybe
//
//  Created by Trevor Rose on 3/28/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit

class FrontPageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func logInTapped(_ sender: Any) {
        let logIn = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogInVC")
        self.present(logIn, animated: true, completion: nil)
    }
    @IBAction func signUpTapped(_ sender: Any) {
        let name = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpName")
        self.present(name, animated: true, completion: nil)
    }
}
