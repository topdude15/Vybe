//
//  AddFriend.swift
//  Vybe
//
//  Created by Trevor Rose on 4/1/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import Foundation
import Firebase

class AddFriend {
    private var _friendId: String!
    
    var friendId: String {
        return _friendId
    }
    init(friendKey: String) {
        _friendId = friendKey
    }
    
}
