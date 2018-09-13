//
//  ISSPosition.swift
//  ISS Position
//
//  Created by Marcin Kuswik on 12.09.2018.
//  Copyright © 2018 Marcin Kuświk. All rights reserved.
//

import Foundation

struct ISSPosition: Codable {
    let latitude: Double
    let longitude: Double
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let latitudeString = try values.decode(String.self, forKey: .latitude)
        let longitudeString = try values.decode(String.self, forKey: .longitude)
        latitude = Double(latitudeString) ?? 0
        longitude = Double(longitudeString) ?? 0
    }
    
}
