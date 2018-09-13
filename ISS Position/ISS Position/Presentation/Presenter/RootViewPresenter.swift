//
//  RootViewPresenter.swift
//  ISS Position
//
//  Created by Marcin Kuswik on 13.09.2018.
//  Copyright © 2018 Marcin Kuświk. All rights reserved.
//

import Foundation

protocol RootViewPresenter {
    
    init(view: RootView, service: ISSInfoService)
    
    func updateListOfAtronatus()
    
    func updateISSPosition()
    
    func startUpdatingISSPosition()
    
    func stopUpdatingISSPosition()
    
}
