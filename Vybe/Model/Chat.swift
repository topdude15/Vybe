//
//  Chat.swift
//  Vybe
//
//  Created by Trevor Rose on 4/2/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import Foundation
import Firebase

class Chat {
    private var _message: String?
    private var _postImage: String?
    private var _poster: String!
    private var _postId: String!
    private var _photoUrl: String?
    
    var message: String? {
        return _message
    }
    var postImage: String? {
        return _postImage
    }
    var poster: String {
        return _poster
    }
    var postId: String {
        return _postId
    }
    var photoUrl: String? {
        return _photoUrl
    }
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        if let message = postData["message"] as? String {
                self._message = message
        }
        self._postId = postKey
        if let pImage = postData["postImage"] as? String {
            self._postImage = pImage
        }
        if let poster = postData["senderId"] as? String {
            self._poster = poster
        } else {
            self._poster = "nan"
        }
        if let photoUrl = postData["photoUrl"] as? String {
            self._photoUrl = photoUrl
        }
        
    }
}
