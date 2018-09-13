//
//  PersistenceUserDefaults.swift
//  ISS Position
//
//  Created by Marcin Kuswik on 13.09.2018.
//  Copyright © 2018 Marcin Kuświk. All rights reserved.
//

import Foundation

class PersistenceUserDefaults: Persistence {
    
    let userDefaults = UserDefaults.standard
    
    func set(object: Any?, forKey key: String) {
        userDefaults.setValue(object, forKey: key)
    }
    
    func getObject(forKey key: String) -> Any? {
        return userDefaults.object(forKey:key)
    }
    
}
