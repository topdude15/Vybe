//
//  SendListVC.swift
//  Vybe
//
//  Created by Trevor Rose on 4/15/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit
import Firebase

class SendListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var image: UIImage = UIImage()
    var videoURL: URL!
    var imageSelected = false
    
    var friends = [Send]()
    
    var friendList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        let uid = Auth.auth().currentUser?.uid
        
        Database.database().reference().child("friendships").child(uid!).observeSingleEvent(of: .value) { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if (snap.value as! Int == 2) {
                        Database.database().reference().child("users").child(snap.key).observeSingleEvent(of: .value, with: { (dataSnap) in
                            let friendId = dataSnap.key
                            let friend = Send(key: friendId)
                            self.friends.insert(friend, at: 0)
                            self.tableView.reloadData()
                        })
                    }
                }
            }
        }
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let info = friends[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SendCell") as? SendCell {
            cell.configureCell(data: info)
            return cell
        } else {
            return SendCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = friends[indexPath.row]
        friendList.append(data.friendUid)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func sendButton(_ sender: Any) {
        
        let uid = Auth.auth().currentUser?.uid
        
        if (imageSelected) {
            if let imgData = UIImageJPEGRepresentation(image, 0.2) {
                let imgUid = NSUUID().uuidString
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"
                
                Storage.storage().reference().child("postPics").child(imgUid).putData(imgData, metadata: metadata) { (metadata, error) in
                    if error != nil {
                        print(error ?? "Unknown error")
                    } else {
                        let downloadUrl = metadata?.downloadURL()?.absoluteString
                        let imageLink = downloadUrl!
                        for user in self.friendList {
                            let referenceInfo: Dictionary<String, AnyObject> = [
                                "senderId": uid as AnyObject,
                                "recieverId": user as AnyObject,
                                "photoUrl": imageLink as AnyObject
                            ]
                            Database.database().reference().child("users").child(user).child("messages").child(uid!).observeSingleEvent(of: .value) { (snapshot) in
                                let refKey = snapshot.value
                                let newKey = Database.database().reference().child("messages").child(refKey as! String).childByAutoId()
                                newKey.updateChildValues(referenceInfo)
                                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
        } else {
            let vidUid = NSUUID().uuidString
            let storageReference = Storage.storage().reference().child("postVids").child(vidUid)
            storageReference.putFile(from: videoURL, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "Unknown Error")
                } else {
                    let downloadUrl = metadata?.downloadURL()?.absoluteString

                    for user in self.friendList {
                        let referenceInfo: Dictionary<String, AnyObject> = [
                            "senderId": uid as AnyObject,
                            "recieverId": user as AnyObject,
                            "videoUrl": downloadUrl as AnyObject
                        ]
                        Database.database().reference().child("users").child(user).child("messages").child(uid!).observeSingleEvent(of: .value) { (snapshot) in
                            let refKey = snapshot.value
                            let newKey = Database.database().reference().child("messages").child(refKey as! String).childByAutoId()
                            newKey.updateChildValues(referenceInfo)
                            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
}
