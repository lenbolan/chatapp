//
//  Router.swift
//  Window
//
//  Created by lenbo lan on 2020/12/17.
//

import UIKit
import RxSwift

class Router {
    
    private unowned let window: UIWindow
    private let submodules: Submodules
    
    typealias Submodules = (
        landingModule: (_ onStart: @escaping () -> Void) -> UIViewController,
        loginModule: (_ onLogin: @escaping () -> Void, _ swapSignUp: @escaping () -> Void) -> UIViewController,
        signUpModule: (_ onSignUp: @escaping () -> Void, _ swapLogin: @escaping () -> Void) -> UIViewController,
        tabbarModule: (_ onLogout: @escaping () -> Void) -> UIViewController
    )
    
    init(window: UIWindow, submodules: Submodules) {
        self.window = window
        self.submodules = submodules
    }
    
}

extension Router: Routing {
    
    func routeToLanding() -> Single<Void> {
        return Single.create { (single) -> Disposable in
            let landingView = self.submodules.landingModule {
                single(.success(()))
            }
            self.window.rootViewController = landingView
            self.window.makeKeyAndVisible()
            return Disposables.create()
        }
    }
    
    func routeToLogin() -> Single<RouteTo> {
        return Single.create { (single) -> Disposable in
            
            let loginView = self.submodules.loginModule( {
                // On login complete, launch the tabbar
                print("Launch the tabbar from here")
                single(.success(.chatrooms))
            } ) {
                // On swap sign up, launch the sign up view
                single(.success(.signup))
            }
            self.window.rootViewController = loginView
            self.window.makeKeyAndVisible()
            
            return Disposables.create()
        }
    }
    
    func routeToSignup() -> Single<RouteTo> {
        return Single.create { (single) -> Disposable in
            
            let signUpView = self.submodules.signUpModule({
                print("Launch the tabbar from here")
                single(.success(.chatrooms))
            }) {
                single(.success(.login))
            }
            self.window.rootViewController = signUpView
            self.window.makeKeyAndVisible()
            
            return Disposables.create()
        }
    }
    
    func routeToChatrooms() -> Single<RouteTo> {
        return Single.create { (single) -> Disposable in
            
            let tabbarView = self.submodules.tabbarModule {
                single(.success(.login))
            }
            self.window.rootViewController = tabbarView
            self.window.makeKeyAndVisible()
                
            return Disposables.create()
        }
    }
    
}
