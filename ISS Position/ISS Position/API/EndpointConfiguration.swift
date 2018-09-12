//
//  EndpointConfiguration.swift
//  ISS Position
//
//  Created by Marcin Kuswik on 12.09.2018.
//  Copyright © 2018 Marcin Kuświk. All rights reserved.
//

import Alamofire

protocol EndpointConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
}
