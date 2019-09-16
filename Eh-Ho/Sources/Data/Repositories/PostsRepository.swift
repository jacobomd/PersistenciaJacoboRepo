//
//  PostsRepository.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 20/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

protocol PostsRepository {
    func getListPostssByTopic(id: Int, completion: @escaping(Result<ListPostsByTopicResponse, Error>) -> ())
    func createNewPost(id_topic: Int, raw: String, completion: @escaping(Result<AddNewPostResponse, Error>) -> ())
}
