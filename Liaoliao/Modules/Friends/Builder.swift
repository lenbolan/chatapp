//
//  Builder.swift
//  Chatrooms
//
//  Created by lenbo lan on 2020/12/27.
//

import UIKit
import Utility

public final class Builder {
    
    public static func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "Friends", bundle: Bundle(for: self))
        let view = FriendsViewController.instantiate(from: storyboard)
        
        let submodules: Router.Submodules = ()
        let router = Router(viewController: view, submodules: submodules)
        
        view.presenterProducer = { input in
            Presenter(input: input, dependencies: (
                router: router,
                useCases: (
                    input: (),
                    output: ()
                )
            ))
        }
        
        return view
    }
    
}
