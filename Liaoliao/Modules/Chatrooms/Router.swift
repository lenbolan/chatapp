//
//  Router.swift
//  Chatrooms
//
//  Created by lenbo lan on 2020/12/27.
//

import UIKit

protocol Routing {
    func routeToCreate()
}

class Router {
    
    typealias Submodules = (
        createChatroomModule: () -> UIViewController, ()
    )
    
    private weak var viewController: UIViewController?
    private let submodules: Submodules
    
    init(viewController: UIViewController, submodules: Submodules) {
        self.viewController = viewController
        self.submodules = submodules
    }
    
}

extension Router: Routing {
    
    func routeToCreate() {
        let createView = submodules.createChatroomModule()
        self.viewController?.present(createView, animated: true, completion: nil)
    }
    
}
