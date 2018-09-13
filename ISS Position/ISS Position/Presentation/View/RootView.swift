//
//  RootView.swift
//  ISS Position
//
//  Created by Marcin Kuswik on 13.09.2018.
//  Copyright © 2018 Marcin Kuświk. All rights reserved.
//

import Foundation
import Mapbox

protocol RootView: class {
    
    func setStatus(status: String)
    
    func setPosition(withCoordinates coordinates: CLLocationCoordinate2D)
    
    func removeMapAnnotations()

    func addMapAnnotation(withAnnotation annotation: MGLPointAnnotation)
    
}
