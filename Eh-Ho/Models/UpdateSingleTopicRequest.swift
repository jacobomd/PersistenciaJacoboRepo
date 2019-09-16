//
//  UpdateSingleTopicRequest.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 24/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

struct UpdateSingleTopicRequest: APIRequest {
    
    typealias Response = UpdateSingleTopicResponse
    
    let title: String
    let topicId: Int
   
    init(title: String,
         topicId: Int) {
        self.title = title
        self.topicId = topicId
    }
    
    var method: Method {
        return .PUT
    }
    
    var path: String {
        return "/t/-/\(topicId).json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return ["title": title]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
