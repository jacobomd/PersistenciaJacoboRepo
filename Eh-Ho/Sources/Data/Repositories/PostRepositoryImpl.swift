//
//  PostRepositoryImpl.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 20/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class PostRepositoryImpl: PostsRepository {
    
    let session : SessionAPI
    
    init(session: SessionAPI) {
        self.session = session
    }
    
    
    func getListPostssByTopic(id: Int, completion: @escaping (Result<ListPostsByTopicResponse, Error>) -> ()) {
        let request = ListPostsByTopicRequest(id: id)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func createNewPost(id_topic: Int, raw: String, completion: @escaping (Result<AddNewPostResponse, Error>) -> ()) {
        let request = CreatePostRequest(topic_id: id_topic, raw: raw)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    
}
