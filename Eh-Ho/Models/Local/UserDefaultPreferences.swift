//
//  UserDefaultPreferences.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 20/09/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation


class UserDefaultsPreferences {
    
    private let keyUserDateLastDownload = "DATE_LAST_DOWNLOAD"
    
    
    func saveLastDownload() {
        UserDefaults.standard.set(Date(), forKey: keyUserDateLastDownload)
    }
    
    func loadLastDownload() -> Date {
        return UserDefaults.standard.object(forKey: keyUserDateLastDownload) as! Date
    }

}
