//
//  TopicsViewModel.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class TopicsViewModel {
    
    weak var view: TopicsViewControllerProtocol?
    
    private let mDataManagerTopic = DataManager()
    
    let router: TopicsRouter
    let id: Int
    let topicsRepository: TopicsRepository
    
    init(router: TopicsRouter, topicsRepository: TopicsRepository, id: Int) {
        self.router = router
        self.topicsRepository = topicsRepository
        self.id = id
    }
    
    func viewDidLoad() {
       fetchListTopicsByCategory()
    }
    
    func didTapInTopic(id: Int) {
        router.navigateToPosts(id: id)
    }
    
    private func fetchListTopicsByCategory() {
        if CheckInternet.Connection() {
       topicsRepository.getListTopicsByCategory(id: id) { [weak self] result in
           switch result {
           case .success(let value):
              self?.view?.showListTopicsByCategory(topics: value.topicList.topics)
              self?.mDataManagerTopic.saveTopics(topic: value.topicList.topics)
              self?.mDataManagerTopic.saveLastDownload()
            print("llega el valor")
          case .failure:
                self?.view?.showError(with: "Error")
           }
        }
        } else {
            self.view?.showListTopicsCD(topics: mDataManagerTopic.dataTopics(id: id))
        }
    }
}
