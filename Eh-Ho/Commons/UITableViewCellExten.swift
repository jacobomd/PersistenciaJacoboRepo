//
//  UITableViewCellExten.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

protocol ReusableCell {
    
    static var identifier: String { get }
    
}

extension ReusableCell {
    
    static var identifier: String {
        return "\(self)"
    }
}

extension UICollectionViewCell: ReusableCell {}

extension UITableViewCell: ReusableCell {}

extension UITableViewHeaderFooterView: ReusableCell {}
