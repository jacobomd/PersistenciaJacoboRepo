//
//  TabBarController.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    let categoriesController: UIViewController
    let addController: UIViewController
    let users: UIViewController
    
    init(categoriesController: UIViewController, addController: UIViewController, users: UIViewController) {
        self.categoriesController = categoriesController
        self.addController = addController
        self.users = users
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
    }
    
    override func awakeFromNib() {
    
    }
    
    private func configureTabBar() {
        let categoriesController = self.categoriesController
        categoriesController.tabBarItem = UITabBarItem(title: "Topics", image: nil, selectedImage: nil)
        
        let addController = self.addController
        addController.tabBarItem = UITabBarItem(title: "Añadir", image: nil, selectedImage: nil)
        
        let users = self.users
        users.tabBarItem = UITabBarItem(title: "Usuarios", image: nil, selectedImage: nil)
        
        
        self.tabBar.barTintColor = .white
        
        let controllers = [categoriesController,addController,users]
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
     

    }

}
