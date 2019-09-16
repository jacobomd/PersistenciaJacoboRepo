//
//  UpdateSingleTopicResponse.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 24/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct UpdateSingleTopicResponse: Codable {
    let basicTopic: BasicTopic
    
    enum CodingKeys: String, CodingKey {
        case basicTopic = "basic_topic"
    }
}

// MARK: - BasicTopic
struct BasicTopic: Codable {
    let id: Int
    let title, fancyTitle, slug: String
    let postsCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case fancyTitle = "fancy_title"
        case slug
        case postsCount = "posts_count"
    }
}
