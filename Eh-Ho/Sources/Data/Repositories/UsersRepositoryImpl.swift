//
//  UsersRepositoryImpl.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 26/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class UsersRepositoryImpl: UsersRepository {

    let session: SessionAPI
    
    init(session: SessionAPI) {
        self.session = session
    }
    

    func getListUsers(completion: @escaping (Result<ListUsersResponse, Error>) -> ()) {
        let request = ListUsersRequest()
        session.send(request: request) { (result) in
            completion(result)
        }
    }
    
}
