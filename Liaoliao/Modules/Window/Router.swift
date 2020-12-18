//
//  Router.swift
//  Window
//
//  Created by lenbo lan on 2020/12/17.
//

import UIKit

class Router {
    
    private unowned let window: UIWindow
    private let submodules: Submodules
    
    typealias Submodules = (
        landingModule: () -> UIViewController, ()
    )
    
    init(window: UIWindow, submodules: Submodules) {
        self.window = window
        self.submodules = submodules
    }
    
}

extension Router: Routing {
    
    func routeToLanding() {
        let landingView = self.submodules.landingModule()
        self.window.rootViewController = landingView
        self.window.makeKeyAndVisible()
    }
    
}
