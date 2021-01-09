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
        landingModule: (_ onStart: @escaping () -> Void) -> UIViewController,
        loginModule: (_ onLogin: @escaping () -> Void, _ swapSignUp: @escaping () -> Void) -> UIViewController,
        signUpModule: (_ onSignUp: @escaping () -> Void, _ swapLogin: @escaping () -> Void) -> UIViewController,
        tabbarModule: () -> UIViewController
    )
    
    init(window: UIWindow, submodules: Submodules) {
        self.window = window
        self.submodules = submodules
    }
    
}

extension Router: Routing {
    
    func routeToLanding() {
        let landingView = self.submodules.landingModule { [weak self] in
            self?.routeToLogin()
        }
        self.window.rootViewController = landingView
        self.window.makeKeyAndVisible()
    }
    
    func routeToLogin() {
        let loginView = self.submodules.loginModule( { [weak self] in
            // On login complete, launch the tabbar
            print("Launch the tabbar from here")
            self?.routeToChatrooms()
        } ) { [weak self] in
            // On swap sign up, launch the sign up view
            print("Launch the tabbar from here")
            self?.routeToSignup()
        }
        self.window.rootViewController = loginView
        self.window.makeKeyAndVisible()
    }
    
    func routeToSignup() {
        let signUpView = self.submodules.signUpModule({ [weak self] in
            print("Launch the tabbar from here")
            self?.routeToChatrooms()
        }) { [weak self] in
            self?.routeToLogin()
        }
        self.window.rootViewController = signUpView
        self.window.makeKeyAndVisible()
    }
    
    func routeToChatrooms() {
        let tabbarView = self.submodules.tabbarModule()
        self.window.rootViewController = tabbarView
        self.window.makeKeyAndVisible()
    }
    
}
