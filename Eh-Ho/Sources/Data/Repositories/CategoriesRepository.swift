//
//  CategoriesRepository.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 19/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

protocol CategoriesRepository {
    func getListCategories(completion: @escaping(Result<ListCategoriesResponse, Error>) -> ())
}
