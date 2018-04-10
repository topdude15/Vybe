//
//  ChatVC.swift
//  Vybe
//
//  Created by Trevor Rose on 4/2/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit
import Firebase

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageLabel: UITextField!
    
    var chatKey = ""
    var chats = [Chat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        messageLabel.delegate = self
        
        let uid = Auth.auth().currentUser?.uid
        let friendId = Util.ds.friendId
        Database.database().reference().child("users").child(uid!).child("messages").observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.hasChild(friendId) {
                if let dictionary = snapshot.value as? Dictionary<String, AnyObject> {
                    self.chatKey = dictionary[friendId] as! String
                    print("Here: \(self.chatKey)")
                    print(self.chatKey)
                    self.loadTable()
                }
            } else {
                let chatKeyValue = Database.database().reference().child("messages").childByAutoId()
                let initValue: Dictionary<String, AnyObject> = [
                    "init": 1 as AnyObject
                ]
                Database.database().reference().child("users").child(uid!).child("messages").updateChildValues([friendId: chatKeyValue.key])
                Database.database().reference().child("users").child(friendId).child("messages").updateChildValues([uid!: chatKeyValue.key])
                chatKeyValue.updateChildValues(initValue)
                self.loadTable()
            }
        }
        Database.database().reference().child("users").child(friendId).observeSingleEvent(of: .value) { (snapshot) in
            if let dictionary = snapshot.value as? Dictionary<String, AnyObject> {
                let firstName = dictionary["firstName"] as! String
                let lastName = dictionary["lastName"] as! String
                self.nameLabel.text = "\(firstName) \(lastName)"
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    func loadTable() {
        Database.database().reference().child("messages").child(chatKey).observe(.value) { (snapshot) in
            self.chats = []
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let chat = Chat(postKey: key, postData: postDict)
                        self.chats.insert(chat, at: 0)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = chats[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as? ChatCell {
            cell.configureCell(chat: chat)
            return cell
        } else {
            return ChatCell()
        }
    }
    @IBAction func sendTapped(_ sender: Any) {
        if (messageLabel.text != "") {
            let uid = Auth.auth().currentUser?.uid
            let friendId = Util.ds.friendId
            let message = self.messageLabel.text
            let messageValue: Dictionary<String, AnyObject> = [
                "message": message as AnyObject,
                "senderId": uid as AnyObject,
                "recieverId": friendId as AnyObject
            ]
            Database.database().reference().child("messages").child(chatKey).childByAutoId().updateChildValues(messageValue)
            self.messageLabel.text = ""
        }
    }
    
}
