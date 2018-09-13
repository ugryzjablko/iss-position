//
//  Persistence.swift
//  ISS Position
//
//  Created by Marcin Kuswik on 13.09.2018.
//  Copyright © 2018 Marcin Kuświk. All rights reserved.
//

import Foundation

protocol Persistence {
    
    func set(object: Any?, forKey key: String)
    
    func getObject(forKey key: String) -> Any?
    
}
