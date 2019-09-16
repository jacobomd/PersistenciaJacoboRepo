//
//  UsersViewModel.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 26/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class UsersViewModel {
    
    weak var view: UsersViewControllerProtocol?

    let router: UsersRouter
    let usersRepository: UsersRepository
    
    init(router: UsersRouter, usersRepository: UsersRepository) {
        self.router = router
        self.usersRepository = usersRepository
    }
    
    func viewDidLoad() {
        fetchListUsers()
    }
    
    func didTapInTopic(username: String) {
        router.navigateToPosts(username: username)
    }
    
    private func fetchListUsers() {
        print("paso 1")
        
        usersRepository.getListUsers { [weak self] result  in
            switch result {
            case .success(let value):
                self?.view?.showListUsers(users: value.users)
            case .failure:
                self?.view?.showError(with: "Error")
            }
        }

    }
    
}
