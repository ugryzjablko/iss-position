//
//  ISSInfoService.swift
//  ISS Position
//
//  Created by Marcin Kuswik on 12.09.2018.
//  Copyright © 2018 Marcin Kuświk. All rights reserved.
//

import Foundation

final class ISSInfoService {
    
    let persistence: PersistenceUserDefaults
    
    init() {
        persistence = PersistenceUserDefaults()
    }
    
    func getISSPosition(callback: @escaping (ISSNow?, Error?) -> Void) {
        OpenNotifyAPIClient.getPosition { (result) in
            if result.isSuccess {
                callback(result.value, nil)
            }
            else {
                callback(nil, ServiceDataError.failure(NSLocalizedString("ISSInfoService.error.corrupted-data", comment: "")))
            }
        }
    }
    
    func getISSAstronauts(callback: @escaping (Astros?, Error?) -> Void) {
        OpenNotifyAPIClient.getAstronauts { (result) in
            if result.isSuccess {
                callback(result.value, nil)
            }
            else {
                callback(nil, ServiceDataError.failure(NSLocalizedString("ISSInfoService.error.corrupted-data", comment: "")))
            }
        }
    }
    
    func saveISSPosition(issPosition: ISSNow?) {
        if let position = issPosition {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(position) {
                persistence.set(object: encoded, forKey: "issPosition")
            }
        }
    }
    
}
