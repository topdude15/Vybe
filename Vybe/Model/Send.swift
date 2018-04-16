//
//  Send.swift
//  Vybe
//
//  Created by Trevor Rose on 4/15/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import Foundation
import Firebase

class Send {
    private var _firstName: String!
    private var _lastName: String!
    private var _friendUid: String!
    
    var firstName: String {
        return _firstName
    }
    var lastName: String {
        return _lastName
    }
    var friendUid: String {
        return _friendUid
    }
    init(key: String) {
        self._friendUid = key
    }
}
