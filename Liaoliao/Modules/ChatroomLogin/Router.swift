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
    private let swapSignUp: () -> Void
    
    init(viewController: UIViewController,
         onLogin: @escaping () -> Void,
         swapSignUp: @escaping () -> Void) {
        self.viewController = viewController
        self.onLogin = onLogin
        self.swapSignUp = swapSignUp
    }
    
}

extension Router: Routing {
    
    func routeToWindow() {
        onLogin()
    }
    
    func routeToSignUp() {
        swapSignUp()
    }
    
}
