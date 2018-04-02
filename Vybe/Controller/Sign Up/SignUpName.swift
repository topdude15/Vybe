//
//  SignUpName.swift
//  Vybe
//
//  Created by Trevor Rose on 3/31/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit
import Material

class SignUpName: UIViewController {

    @IBOutlet weak var firstNameBox: ErrorTextField!
    @IBOutlet weak var lastNameBox: ErrorTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func continueTapped(_ sender: Any) {
        let firstName = firstNameBox.text
        let lastName = lastNameBox.text
        Util.ds.userInfo.updateValue(firstName as AnyObject, forKey: "firstName")
        Util.ds.userInfo.updateValue(lastName as AnyObject, forKey: "lastName")
        let birthday = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpBirthday")
        present(birthday, animated: true, completion: nil)
    }
}
