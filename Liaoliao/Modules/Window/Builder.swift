//
//  Builder.swift
//  Window
//
//  Created by lenbo lan on 2020/12/17.
//

import UIKit
import Landing
import ChatroomLogin

public final class Builder {
    
    public static func build(windowScene: UIWindowScene) -> UIWindow {
        let window = Window(windowScene: windowScene)
        
        let landingModule = Landing.Builder.build
        let loginModule = ChatroomLogin.Builder.build
        
        let router = Router(
            window: window,
            submodules: (
                landingModule: landingModule,
                loginModule: loginModule
            )
        )
        let presenter = Presenter(router: router)
        window.presenter = presenter
        
        return window
    }
    
}
