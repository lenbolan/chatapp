//
//  Router.swift
//  ChatroomLogin
//
//  Created by lenbo lan on 2020/12/19.
//

import UIKit

class Router {
    
    private weak var viewController: UIViewController?
    private let onLogin: () -> Void
    
    init(viewController: UIViewController, onLogin: @escaping () -> Void) {
        self.viewController = viewController
        self.onLogin = onLogin
    }
    
}

extension Router: Routing {
    
    func routeToWindow() {
        onLogin()
    }
    
}
