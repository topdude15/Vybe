//
//  Friend.swift
//  Vybe
//
//  Created by Trevor Rose on 4/2/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import Foundation
import Firebase

class Friend {
    private var _username: String!
    private var _friendId: String!
    private var _name: String!
    
    var username: String {
        return _username
    }
    var friendId: String {
        return _friendId
    }
    var name: String {
        return _name
    }
    init(friendKey: String, friendData: Dictionary<String, AnyObject>) {
        _friendId = friendKey
        let firstName = friendData["firstName"]
        let lastName = friendData["lastName"]
        _name = "\(firstName as! String) \(lastName as! String)"
        _username = friendData["username"] as! String
    }
}
