//
//  VideoCell.swift
//  Vybe
//
//  Created by Trevor Rose on 4/16/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit
import Firebase

class VideoCell: UITableViewCell {

    var videoURL: String = ""
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(chat: Chat) {
        let userAcc = chat.poster
        videoURL = chat.videoUrl!
        
        Database.database().reference().child("users").child(userAcc).observeSingleEvent(of: .value) { (snapshot) in
            if let dictionary = snapshot.value as? Dictionary<String, AnyObject> {
                let uid = Auth.auth().currentUser?.uid
                if (userAcc == uid) {
                    self.nameLabel.text = "Me"
                } else {
                    let firstName = dictionary["firstName"] as? String
                    let lastName = dictionary["lastName"] as? String
                    self.nameLabel.text = "\(firstName ?? "") \(lastName ?? "")"
                }
            }
        }
    }

}
