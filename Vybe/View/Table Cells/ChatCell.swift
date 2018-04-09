//
//  ChatCell.swift
//  Vybe
//
//  Created by Trevor Rose on 4/2/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit
import Firebase

class ChatCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(chat: Chat) {
        let userAcc = chat.poster
        Database.database().reference().child("users").child(userAcc).observeSingleEvent(of: .value) { (snapshot) in
            if let dictionary = snapshot.value as? Dictionary<String, AnyObject> {
                let uid = Auth.auth().currentUser?.uid
                if (chat.poster == uid) {
                    self.nameLabel.text = "Me"
                } else {
                    let firstName = dictionary["firstName"] as? String
                    let lastName = dictionary["lastName"] as? String
                    self.nameLabel.text = "\(firstName ?? "First") \(lastName ?? "Last")"
                }
            }
        }
        self.messageLabel.text = chat.message
    }

}
