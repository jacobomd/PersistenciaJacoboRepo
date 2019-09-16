//
//  UsersRepository.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 26/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

protocol UsersRepository {
    func getListUsers(completion: @escaping(Result<ListUsersResponse, Error>) -> ())
}
