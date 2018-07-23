//
//  FriendListVC.swift
//  Vybe
//
//  Created by Trevor Rose on 4/2/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit
import Firebase

class FriendListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPageViewControllerDelegate {

    @IBOutlet weak var friendButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var friends = [Friend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("friendships").child(uid!).observeSingleEvent(of: .value) { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if (snap.value as! Int == 2) {
                        let friendId = snap.key
                        self.getFriend(friendId: friendId)
                    }
                }
            }
        }
    }
    func getFriend(friendId: String) {
        Database.database().reference().child("users").child(friendId).observeSingleEvent(of: .value) { (snapshot) in
            if let postDict = snapshot.value as? Dictionary<String, AnyObject> {
                let key = snapshot.key
                let friend = Friend(friendKey: key, friendData: postDict)
                self.friends.append(friend)
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = friends[indexPath.row]
        Util.ds.friendId = friend.friendId
        self.performSegue(withIdentifier: "chat", sender: nil)

//        let chat = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatVC")
//        self.present(chat, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friend = friends[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? FriendCell {
            cell.backgroundColor = UIColor.clear
            cell.configureCell(friend: friend)
            return cell
        } else {
            return FriendCell()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
