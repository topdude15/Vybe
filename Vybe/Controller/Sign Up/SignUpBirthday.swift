//
//  SignUpBirthday.swift
//  Vybe
//
//  Created by Trevor Rose on 3/31/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit

class SignUpBirthday: UIViewController {

    @IBOutlet weak var birthdayPicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func continueTapped(_ sender: Any) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = DateFormatter.Style.short
        let strDate = timeFormatter.string(from: birthdayPicker.date)
        Util.ds.userInfo.updateValue(strDate as AnyObject, forKey: "birthday")
        let username = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpUsername")
        self.present(username, animated: true, completion: nil)
    }
    
}
