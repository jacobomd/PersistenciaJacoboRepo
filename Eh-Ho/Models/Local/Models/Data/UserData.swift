//
//  UserData.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 21/09/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class UserData {
    
    var name: String = ""
    var userName: String = ""
    var idUser: Int = -1
    
    convenience init(name: String, userName: String, idUser: Int) {
        self.init()
        
        self.name = name
        self.userName = userName
        self.idUser = idUser
    }
}
