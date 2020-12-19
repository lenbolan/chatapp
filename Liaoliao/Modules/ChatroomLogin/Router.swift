//
//  Router.swift
//  ChatroomLogin
//
//  Created by lenbo lan on 2020/12/19.
//

import UIKit

class Router {
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
}

extension Router: Routing {
    
}
