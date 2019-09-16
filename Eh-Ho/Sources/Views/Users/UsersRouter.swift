//
//  UsersRouter.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 26/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class UsersRouter {
    
    weak var viewController: UIViewController?
    
    static func configureModule() -> UIViewController {
        
        let router = UsersRouter()

        let sessionApi = SessionAPI()
        
        let usersRepository = UsersRepositoryImpl(session: sessionApi)

        let viewModel = UsersViewModel(router: router, usersRepository: usersRepository)

        let viewController = UsersViewController(viewModel: viewModel)
        
        viewModel.view = viewController
        router.viewController = viewController
        
        return viewController
    }
    
    func navigateToPosts(username: String) {
        let viewControllerToPush = SendMessageRouter.configureModule(target_usernames: username)
        viewController?.navigationController?.pushViewController(viewControllerToPush, animated: true)
    }
    
}
