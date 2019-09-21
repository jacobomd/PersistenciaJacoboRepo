//
//  CategoryData.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 21/09/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class CategoryData {
    
    var categoryId: Int = -1
    var name: String = ""
    
    convenience init(categoryId: Int = -1, name: String) {
        self.init()
        self.categoryId = categoryId
        self.name = name
        
    }
}
