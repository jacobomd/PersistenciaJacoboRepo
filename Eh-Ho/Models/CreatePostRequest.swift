//
//  CreatePostRequest.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 21/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

struct CreatePostRequest: APIRequest {
    
    typealias Response = AddNewPostResponse
    
    let topic_id: Int
    let raw: String
    
    init(topic_id: Int, raw: String) {
        self.topic_id = topic_id
        self.raw = raw
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
        return ["topic_id": topic_id,
                "raw": raw]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
