//
//  Builder.swift
//  Window
//
//  Created by lenbo lan on 2020/12/17.
//

import UIKit
import Landing
import ChatroomLogin
import ChatroomSignUp
import Tabbar

import UseCases

public final class Builder {
    
    public static func build(windowScene: UIWindowScene) -> UIWindow {
        let window = Window(windowScene: windowScene)
        
        let landingModule = Landing.Builder.build
        let loginModule = ChatroomLogin.Builder.build
        let signUpModule = ChatroomSignUp.Builder.build
        let tabbarModule = Tabbar.Builder.build
        
        let accountInteractor = UseCasesFactory.accoutsInteractor
        
        let router = Router(
            window: window,
            submodules: (
                landingModule: landingModule,
                loginModule: loginModule,
                signUpModule: signUpModule,
                tabbarModule: tabbarModule
            )
        )
        let presenter = Presenter(router: router,
                                  useCases: (
                                    validate: accountInteractor.validate, ()
                                  ))
        window.presenter = presenter
        
        return window
    }
    
}
