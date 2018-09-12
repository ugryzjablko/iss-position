//
//  OpenNotifyEndpoint.swift
//  ISS Position
//
//  Created by Marcin Kuswik on 12.09.2018.
//  Copyright © 2018 Marcin Kuświk. All rights reserved.
//

import Foundation

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
        
        var urlRequest = prepareURLRequest(baseUrl: baseUrl, path: path)
        urlRequest?.httpMethod = method
        
        return urlRequest
    }
    
}

extension OpenNotifyEndpoint {
    func prepareURLRequest(baseUrl: URL?, path: String?) -> URLRequest? {
        let url = baseUrl?.appendingPathExtension(path)
        if let url = url {
            return URLRequest(url)
        }
        return nil
    }
}
