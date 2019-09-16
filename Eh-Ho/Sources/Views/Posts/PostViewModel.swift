//
//  PostViewModel.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 20/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class PostViewModel {
    
    weak var  view: PostsViewControllerProtocol?
    let router: PostRouter
    let id: Int
    let postsRepository: PostsRepository
    let topicRepository: TopicsRepository
    
    init(router: PostRouter, id: Int, postsRepository: PostsRepository, topicRepository: TopicsRepository) {
        self.router = router
        self.id = id
        self.postsRepository = postsRepository
        self.topicRepository = topicRepository
    }
    
    func viewDidLoad() {
        fetchListPostssByTopic()
        
    }
    
    func didTapInTopic(id: Int) {
        router.navigateToPosts(id: id)
    }
    
    func didUpDateTopic(title: String) {
        updateSingleTopic(title: title)
    }
    
    
   private func fetchListPostssByTopic () {
        postsRepository.getListPostssByTopic(id: id) { [weak self] result in
            switch result {
            case .success(let value):
                self?.view?.showListPostssByTopic(posts: value.postStream.posts)
                print("llega el valor")
            case .failure:
                self?.view?.showError(with: "Error")
            }
        }
    }
    
    private func updateSingleTopic(title: String) {
        topicRepository.updateSingleTopic(idTopic: id, title: title) { [weak self] result in
            switch result {
            case .success:
                print("ha sido satisfactorio")
            // no enviamos nada a mostrar a la vista
            case .failure:
                self?.view?.showError(with: "Error")
                print("no ha se ha actualizado el topic")
            }
        }
    }
    
}
