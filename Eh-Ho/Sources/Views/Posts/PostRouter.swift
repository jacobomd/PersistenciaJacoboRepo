//
//  PostRouter.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 20/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class PostRouter {
    
    weak var viewController: UIViewController?
    
    static func configureModule(id: Int) -> UIViewController {
        
        let router = PostRouter()
        let sessionApi = SessionAPI()
        let postsRepository = PostRepositoryImpl(session: sessionApi)
        let topicRepository = TopicsRepositoryImpl(session: sessionApi)
        let viewModel = PostViewModel(router: router, id: id, postsRepository: postsRepository, topicRepository: topicRepository)
        let viewController = PostsViewController(viewModel: viewModel)
        
        viewModel.view = viewController
        router.viewController = viewController
        
        return viewController
    }
    
    func navigateToPosts(id: Int) {
        let viewControllerToPush = PostCreateRouter.configureModule(id: id)
        viewController?.navigationController?.pushViewController(viewControllerToPush, animated: true)
    }
    
}
