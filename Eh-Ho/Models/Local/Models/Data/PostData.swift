//
//  PostData.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 21/09/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class PostData {
    
    var postId: Int = -1
    var cooked: String = ""
    var canEdit: Bool = false
    var topicId: Int = 0
    
    convenience init(postId: Int = -1, cooked: String, canEdit: Bool, topicId: Int ) {
        self.init()
        
        self.postId = postId
        self.cooked = cooked
        self.canEdit = canEdit
        self.topicId = topicId
        
    }
}
