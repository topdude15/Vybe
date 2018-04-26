//
//  SendCell.swift
//  Vybe
//
//  Created by Trevor Rose on 4/15/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit
import Firebase

class SendCell: UITableViewCell {


    @IBOutlet weak var selectedCellImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(data: Send) {
        let uid = Auth.auth().currentUser?.uid
        if data.friendUid == uid {
            self.nameLabel.text = "My Story"
        } else {
            Database.database().reference().child("users").child(data.friendUid).observeSingleEvent(of: .value) { (snapshot) in
                if let dictionary = snapshot.value as? Dictionary<String, AnyObject> {
                    let firstName = dictionary["firstName"] as? String
                    let lastName = dictionary["lastName"] as? String
                    self.nameLabel.text = ("\(firstName ?? "FIRST") \(lastName ?? "LAST")")
                }
            }
        }
        
    }

}
