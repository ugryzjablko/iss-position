//
//  AppController.swift
//  ISS Position
//
//  Created by Marcin Kuswik on 12.09.2018.
//  Copyright © 2018 Marcin Kuświk. All rights reserved.
//

import UIKit

final class AppController {
    
    let rootViewController = RootViewController()
    
    func presentRootController(withWindow window: UIWindow?) {
        if let appWindow = window {
            
            let rootView = RootViewController()
            let presenter = RootPresenter(view: rootView, service: ISSInfoService())
            rootView.presenter = presenter
            
            appWindow.rootViewController = rootView
            appWindow.makeKeyAndVisible()
        }
    }
    
}
