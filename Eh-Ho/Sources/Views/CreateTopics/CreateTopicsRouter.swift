//
//  CreateTopicsRouter.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 25/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class CreateTopicsRouter {
    
    weak var viewController: UIViewController?
    
    static func configureModule() -> UIViewController {
        
        let router = CreateTopicsRouter()
        let sessionAPI = SessionAPI()
        let topicsRepository = TopicsRepositoryImpl(session: sessionAPI)
        let viewModel = CreateTopicsViewModel(router: router, topicRepository: topicsRepository)
        let viewController = CreateTopicsViewController(viewModel: viewModel)
        
        viewModel.view = viewController
        router.viewController = viewController
        
        return viewController
        
    }
    
    func navigateToPosts() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
    
}
