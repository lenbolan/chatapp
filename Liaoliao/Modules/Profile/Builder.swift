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
    
    public static func build(usingNavigationFactory factory: NavigationFactory) -> UIViewController {
        let storyboard = UIStoryboard(name: "Profile", bundle: Bundle(for: self))
        let view = ProfileViewController.instantiate(from: storyboard)
        view.title = "Profile"
        
        let submodules: Router.Submodules = ()
        
        let accountInteractor = UseCasesFactory.accoutsInteractor
        
        let router = Router(viewController: view, submodules: submodules)
        
        view.presenterProducer = { input in
            Presenter(input: input, dependencies: (
                router: router,
                useCases: (
                    input: (),
                    output: (
                        profileUser: accountInteractor.user.filter( { $0 != nil } ).map( { $0! } ), ()
                    )
                )
            ))
        }
        
        return factory(view)
    }
    
}
