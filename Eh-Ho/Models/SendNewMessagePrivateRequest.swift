//
//  SendNewMessagePrivateRequest.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 27/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

struct SendNewMessagePrivateRequest: APIRequest {
    
    typealias Response = SendNewMessagePrivateResponse
    
    let title: String
    let raw: String
    let target_usernames: String
    var archetype: String
    
    init(title: String,
         raw: String,
         target_usernames: String) {
        self.title = title
        self.raw = raw
        self.target_usernames = target_usernames
        self.archetype = "private_message"
    }
    
    var method: Method {
        return .POST
    }
    
    var path: String {
        return "/posts.json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return ["title": title,
                "raw": raw,
                "target_usernames": target_usernames,
                "archetype": archetype
        ]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
