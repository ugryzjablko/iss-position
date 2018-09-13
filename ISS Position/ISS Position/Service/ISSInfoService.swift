//
//  ISSInfoService.swift
//  ISS Position
//
//  Created by Marcin Kuswik on 12.09.2018.
//  Copyright © 2018 Marcin Kuświk. All rights reserved.
//

import Foundation

final class ISSInfoService {
    
    static func getISSPosition(callback: @escaping (ISSNow?, Error?) -> Void) {
        OpenNotifyAPIClient.getPosition { (result) in
            if result.isSuccess {
                callback(result.value, nil)
            }
            else {
                callback(nil, ServiceDataError.failure("There was some problems with data!"))
            }
        }
    }
    
    static func getISSAstronauts(callback: @escaping (Astros?, Error?) -> Void) {
        OpenNotifyAPIClient.getAstronauts { (result) in
            if result.isSuccess {
                callback(result.value, nil)
            }
            else {
                callback(nil, ServiceDataError.failure("There was some problems with data!"))
            }
        }
    }
    
}