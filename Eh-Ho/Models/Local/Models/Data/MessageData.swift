//
//  MessageData.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 17/09/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class MessageData {
    
    var title: String = ""
    var raw: String = ""
    var target_usernames: String = ""
    var archetype: String = ""
    
    convenience init(title: String, raw: String, target_usernames: String, archetype: String) {
        self.init()
        
        self.title = title
        self.raw = raw
        self.target_usernames = target_usernames
        self.archetype = archetype
        
    }
}
