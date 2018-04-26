//
//  Story.swift
//  Vybe
//
//  Created by Trevor Rose on 4/26/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import Foundation
import Firebase

class Story {
    private var _poster: String!
    private var _storyImage: String!
    
    var poster: String {
        return _poster
    }
    var storyImage: String {
        return _storyImage
    }
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        
    }
}
