//
//  MessagesPrivatesRepository.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 27/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

protocol MessagesPrivatesRepository {
    func createSendNewMessagePrivate(title: String, raw: String, target_usernames: String, completion: @escaping(Result<SendNewMessagePrivateResponse, Error>) -> ())
}
