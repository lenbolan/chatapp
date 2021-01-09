//
//  Builder.swift
//  Chatrooms
//
//  Created by lenbo lan on 2020/12/27.
//

import UIKit
import Utility
import UseCases

public final class Builder {
    
    public static func build(onSignUp: @escaping () -> Void,
                             swapLogin: @escaping () -> Void) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "ChatroomSignUp", bundle: Bundle(for: self))
        let view = SignUpViewController.instantiate(from: storyboard)
        
        let accountInteractor = UseCasesFactory.accoutsInteractor
        
        let submodules: Router.Submodules = ()
        
        let router = Router(viewController: view,
                            submodules: submodules,
                            onSignUp: onSignUp,
                            swapLogin: swapLogin)
        
        view.presenterProducer = { input in
            Presenter(input: input, dependencies: (
                router: router,
                useCases: (
                    input: (
                        signUp: accountInteractor.signUp,
                        ()
                    ),
                    output: ()
                )
            ))
        }
        
        return view
        
    }
    
}
