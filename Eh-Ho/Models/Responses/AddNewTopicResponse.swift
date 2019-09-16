//
//  AddNewTopicResponse.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 17/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

// MARK: - AddNewTopicResponse
struct AddNewTopicResponse: Codable {
    
    let id: Int
    
    let name: String
    
    let username: String
    
    let avatarTemplate: String
    
    let createdAt: String
    
    let cooked: String
    
    let postNumber: Int
    
    let postType: Int
    
    let updatedAt: String
    
    let replyCount: Int
    
    let quoteCount: Int
    
    let incomingLinkCount: Int
    
    let reads: Int
    
    let score: Int
    
    let yours: Bool
    
    let topicID: Int
    
    let topicSlug: String
    
    let displayUsername: String
    
    let version: Int
    
    let canEdit: Bool
    
    let canDelete: Bool
    
    let canRecover: Bool
    
    let canWiki: Bool
    
    let actionsSummary: [ActionsSummary]
    
    let moderator: Bool
    
    let admin: Bool
    
    let staff: Bool
    
    let userID: Int
    
    let draftSequence: Int
    
    let hidden: Bool
    
    let trustLevel: Int
    
    let userDeleted: Bool
    
    let canViewEditHistory: Bool
    
    let wiki: Bool
    
    
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        
        case name = "name"
        
        case username = "username"
        
        case avatarTemplate = "avatar_template"
        
        case createdAt = "created_at"
        
        case cooked = "cooked"
        
        case postNumber = "post_number"
        
        case postType = "post_type"
        
        case updatedAt = "updated_at"
        
        case replyCount = "reply_count"
        
        case quoteCount = "quote_count"
        
        case incomingLinkCount = "incoming_link_count"
        
        case reads = "reads"
        
        case score = "score"
        
        case yours = "yours"
        
        case topicID = "topic_id"
        
        case topicSlug = "topic_slug"
        
        case displayUsername = "display_username"
        
        case version = "version"
        
        case canEdit = "can_edit"
        
        case canDelete = "can_delete"
        
        case canRecover = "can_recover"
        
        case canWiki = "can_wiki"
        
        case actionsSummary = "actions_summary"
        
        case moderator = "moderator"
        
        case admin = "admin"
        
        case staff = "staff"
        
        case userID = "user_id"
        
        case draftSequence = "draft_sequence"
        
        case hidden = "hidden"
        
        case trustLevel = "trust_level"
        
        case userDeleted = "user_deleted"
        
        case canViewEditHistory = "can_view_edit_history"
        
        case wiki = "wiki"
        
    }
    
}



// MARK: - ActionsSummary

struct ActionsSummary: Codable {
    
    let id: Int
    
    let canAct: Bool
    
    
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        
        case canAct = "can_act"
        
    }
    
}
