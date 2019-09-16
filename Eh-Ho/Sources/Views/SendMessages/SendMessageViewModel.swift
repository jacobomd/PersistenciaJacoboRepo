//
//  SendMessageViewModel.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 27/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class SendMessageViewModel {
    
    weak var view: SendMessageViewControllerProtocol?
    let router: SendMessageRouter
    let messagesPrivatesRepository: MessagesPrivatesRepository
    let target_usernames: String
    
    init(router: SendMessageRouter, messagesPrivatesRepository: MessagesPrivatesRepository, target_usernames: String) {
        self.router = router
        self.messagesPrivatesRepository = messagesPrivatesRepository
        self.target_usernames = target_usernames
    }
    
    func viewDidLoad() {
        
    }
    
    func didTapInTopic(title: String, raw: String) {
        createMessagePrivate(title: title, raw: raw)
        router.navigateToPosts()
    }
    
    private func createMessagePrivate(title: String, raw: String) {
        messagesPrivatesRepository.createSendNewMessagePrivate(title: title, raw: raw, target_usernames: self.target_usernames) { (result) in
            switch result {
            case .success( _):
                self.view?.sendMessagePrivate()
            // no enviamos nada a mostrar a la vista
            case .failure:
                self.view?.showError(with: "Error")
            }
        }

    }
}


