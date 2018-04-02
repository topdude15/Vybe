//
//  AddFriendVC.swift
//  Vybe
//
//  Created by Trevor Rose on 4/1/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit
import Material
import Firebase

class AddFriendVC: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var usernameBox: ErrorTextField!

    @IBOutlet weak var declineFriend: UIButton!
    @IBOutlet weak var acceptFriend: UIButton!
    @IBOutlet weak var requestLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var friends = [AddFriend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadTable()
        
    }
    func loadTable() {
        self.friends = []
        self.tableView.reloadData()
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("friendships").child(uid!).observe(.value) { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if (snap.value as! Int == 1) {
                        let requestId = snap.key
                        let friend = AddFriend(friendKey: requestId)
                        self.friends.insert(friend, at: 0)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    @IBAction func addFriendTapped(_ sender: Any) {
        Database.database().reference().child("usernames").observeSingleEvent(of: .value) { (snapshot) in
            let username = self.usernameBox.text
            if snapshot.hasChild(username!) {
                if let dictionary = snapshot.value as? Dictionary<String, AnyObject> {
                    let uid = Auth.auth().currentUser?.uid
                    let friendUid = dictionary[username!]
                    let selfUserData: Dictionary<String, AnyObject> = [
                        friendUid as! String: 0 as AnyObject
                    ]
                    let otherUserData: Dictionary<String, AnyObject> = [
                        uid!: 1 as AnyObject
                    ]
                    Database.database().reference().child("friendships").child(uid!).updateChildValues(selfUserData)
                    Database.database().reference().child("friendships").child(friendUid as! String).updateChildValues(otherUserData)
                }
            } else {
                print("Friend not found")
            }
        }
    }
    @IBAction func acceptFriend(_ sender: Any) {
        
    }
    @IBAction func declineFriend(_ sender: Any) {
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friend = friends[indexPath.row]
        print("here")
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? AddFriendCell{
            cell.configureCell(friend: friend)
            return cell
        }
        else{
            return AddFriendCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = friends[indexPath.row]
        print("here")
        let friendId = friend.friendId
        let uid = Auth.auth().currentUser?.uid
        print("Also here")
        Database.database().reference().child("friendships").child(friendId).updateChildValues([uid!: 2])
        Database.database().reference().child("friendships").child(uid!).updateChildValues([friendId: 2])
        self.loadTable()
    }

}
