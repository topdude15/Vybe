//
//  AddFriendCell.swift
//  Vybe
//
//  Created by Trevor Rose on 4/1/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit
import Firebase

class AddFriendCell: UITableViewCell {

    @IBOutlet weak var nameBox: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    let addButton: UIButton = {
        var id : String?
        let button = UIButton()
        button.setTitle("+Add", for: .normal)
        button.setTitleColor(UIColor.brown, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubview(addButton)
        
        addButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        addButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        addButton.heightAnchor.constraint(equalTo: (textLabel?.heightAnchor)!).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configureCell(friend: AddFriend) {
        Database.database().reference().child("users").child(friend.friendId).observeSingleEvent(of: .value) { (snapshot) in
            if let dictionary = snapshot.value as? Dictionary<String, AnyObject> {
                let friendName = dictionary["username"]
                self.nameBox.text = "\(friendName ?? "Trevor" as AnyObject) would like to be your friend"
            }
        }
    }
    
}
