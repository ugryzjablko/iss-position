//
//  OpenNotifyAPIClient.swift
//  ISS Position
//
//  Created by Marcin Kuswik on 12.09.2018.
//  Copyright © 2018 Marcin Kuświk. All rights reserved.
//

import Alamofire

final class OpenNotifyAPIClient {
    
    @discardableResult
    private static func request<T:Decodable>(endpoint:EndpointConfiguration, decoder aDecoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T>)->Void) -> DataRequest {
        return Alamofire.request(endpoint).responseData(completionHandler: {
            (response) in
            let decoder = aDecoder
            let result: Result<T> = decoder.decodeResponse(from: response)
            completion(result)
        })
    }
    
    static func getPosition(completion: @escaping (Result<ISSNow>) -> Void) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        request(endpoint: OpenNotifyEndpoint.position, decoder: decoder, completion: completion)
    }
    
    static func getAstronauts(completion: @escaping (Result<Astros>) -> Void) {
        request(endpoint: OpenNotifyEndpoint.astronauts, completion: completion)
    }
    
}
