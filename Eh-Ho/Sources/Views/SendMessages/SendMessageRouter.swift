//
//  SendMessageRouter.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 27/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class SendMessageRouter {
    
    weak var viewController: UIViewController?
    
    static func configureModule(target_usernames: String) -> UIViewController {
        
        let router = SendMessageRouter()
        let sessionApi = SessionAPI()
        let messagesPrivateRepository = MessagesPrivatesRepositoryImpl(session: sessionApi)
        let viewModel = SendMessageViewModel(router: router, messagesPrivatesRepository: messagesPrivateRepository, target_usernames: target_usernames )
        let viewController = SendMessageViewController(viewModel: viewModel)
        
        viewModel.view = viewController
        router.viewController = viewController
        
        return viewController
    }
    
    func navigateToPosts() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
    
}
