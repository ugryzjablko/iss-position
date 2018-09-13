//
//  ISSNow.swift
//  ISS Position
//
//  Created by Marcin Kuswik on 12.09.2018.
//  Copyright © 2018 Marcin Kuświk. All rights reserved.
//

import Foundation

struct ISSNow: Codable {
    let message: String
    let issPosition: ISSPosition
    let timestamp: UInt
}

extension ISSNow {
    enum CodingKeys: String, CodingKey {
        case message
        case issPosition = "iss_position"
        case timestamp
    }
}
