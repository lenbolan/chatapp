//
//  Builder.swift
//  ChatroomLogin
//
//  Created by lenbo lan on 2020/12/18.
//

import UIKit
import Utility
import UseCases

public final class Builder {
    
    public static func build(onLogin: @escaping () -> Void) -> UIViewController {
        let storyboard = UIStoryboard.init(name: "ChatroomLogin", bundle: Bundle.init(for: self))
        let view = ChatroomLoginViewController.instantiate(from: storyboard)
        
        let accountInteractor = UseCasesFactory.accoutsInteractor
        
        let router = Router(viewController: view, onLogin: onLogin)
        
        view.presenterProducer = {
            Presenter(
                input: $0,
                router: router,
                useCases: (
                    login: accountInteractor.login,
                    ()
                )
            )
        }
        
        return view
    }
    
}
