//
//  DetailViewModel.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class DetailTopicViewModel {
    
    weak var view: DetailTopicViewControllerProtocol?
    let id: Int
    let router: DetailTopicRouter
    let topicsRepository: TopicsRepository
    
    init(id: Int,
         router: DetailTopicRouter,
         topicsRepository: TopicsRepository) {
        self.id = id
        self.router = router
        self.topicsRepository = topicsRepository
    }
    
    func viewDidLoad() {
       // fetchSingleTopic()
    }
    
//    private func fetchSingleTopic() {
//        topicsRepository.getSingleTopicById(id: id) { result in
//            switch result {
//            case .success(let value):
//                //Enviariamos a la vista para mostrar la info
//                print("LLEGA EL VALOR")
//            case .failure(let error):
//                //Enviaremos a la vista el error
//                break
//            }
//        }
//    }
}
