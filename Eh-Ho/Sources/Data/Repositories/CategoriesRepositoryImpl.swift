//
//  CategoriesRepositoryImpl.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 19/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class CategoriesRepositoryImpl: CategoriesRepository {

    let session: SessionAPI
    
    init(session: SessionAPI) {
        self.session = session
    }
    
    func getListCategories(completion: @escaping (Result<ListCategoriesResponse, Error>) -> ()) {
        let request = ListCategoriesRequest()
        session.send(request: request) { result in
            completion(result)
        }
    }
    
}
