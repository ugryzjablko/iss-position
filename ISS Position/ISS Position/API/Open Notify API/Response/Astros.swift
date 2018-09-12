//
//  Astros.swift
//  ISS Position
//
//  Created by Marcin Kuswik on 12.09.2018.
//  Copyright © 2018 Marcin Kuświk. All rights reserved.
//

import Foundation

struct Astros: Codable {
    let message: String
    let people: [Astronaut]
    let number: Int
}
