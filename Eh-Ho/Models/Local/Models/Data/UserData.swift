//
//  UserData.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 17/09/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class UserData {
    
    var name: String = ""
    var userName: String = ""
    
    convenience init(name: String, userName: String) {
        self.init()
        
        self.name = name
        self.userName = userName
        
    }
}
