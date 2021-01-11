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
        let storyboard = UIStoryboard(name: "Chatrooms", bundle: Bundle(for: self))
        let view = ChatroomsViewController.instantiate(from: storyboard)
        view.title = "Rooms"
        
        let chatroomsInteractor = UseCasesFactory.chatroomsInteractor
        
        let submodules: Router.Submodules = ()
        
        let router = Router(viewController: view, submodules: submodules)
        
        view.presenterProducer = { input in
            Presenter(input: input, dependencies: (
                router: router,
                useCases: (
                    input: (
                        fetchChatrooms: chatroomsInteractor.fetchChatrooms, ()
                    ),
                    output: (
                        chatrooms: chatroomsInteractor.chatrooms, ()
                    )
                )
            ))
        }
        
        return factory(view)
    }
    
}
