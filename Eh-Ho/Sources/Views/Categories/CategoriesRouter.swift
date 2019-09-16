//
//  CategoriesRouter.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 19/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class CategoriesRouter {
    
    weak var viewController: UIViewController?
    
    static func configureModule() -> UIViewController {
        
        let router = CategoriesRouter()
        let sessionAPI = SessionAPI()
        let categoriesRepository = CategoriesRepositoryImpl(session: sessionAPI)
        let viewModel = CategoriesViewModel(router: router, categoriesRepository: categoriesRepository)
        let viewController = CategoriesViewController(viewModel: viewModel)
        
        viewModel.view = viewController
        router.viewController = viewController
        
        return viewController
        
    }
    
    func navigateToTopicsById (id: Int) {
        let viewControllerToPush = TopicsRouter.configureModule(id: id)
        viewController?.navigationController?.pushViewController(viewControllerToPush, animated: true)
    }
}
