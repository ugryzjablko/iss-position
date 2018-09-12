//
//  OpenNotifyEndpoint.swift
//  ISS Position
//
//  Created by Marcin Kuswik on 12.09.2018.
//  Copyright © 2018 Marcin Kuświk. All rights reserved.
//

import Alamofire

enum OpenNotifyEndpoint: EndpointConfiguration {
    
    case position
    case astronauts
    
    var method: HTTPMethod {
        switch self {
        case .position, .astronauts:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .position:
            return "/iss-now.json"
        case .astronauts:
            return "/astros.json"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let baseUrl = try OpenNotifyConstants.API.baseURL.asURL()
        let url = baseUrl.appendingPathComponent(path)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
    
}
