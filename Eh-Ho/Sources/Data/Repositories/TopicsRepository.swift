//
//  File.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

protocol TopicsRepository {
    func getSingleTopicById(id: Int, completion: @escaping(Result<SingleTopicResponse, Error>) -> ())
    func getListTopicsByCategory(id: Int, completion: @escaping(Result<ListTopicsByCategoryResponse, Error>) -> ())
    func updateSingleTopic(idTopic: Int,title: String, completion: @escaping(Result<UpdateSingleTopicResponse, Error>) -> ())
    func createNewTopic(title: String, raw: String, completion: @escaping(Result<AddNewTopicResponse, Error>) -> ())
}
