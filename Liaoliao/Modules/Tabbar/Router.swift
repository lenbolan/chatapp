//
//  Router.swift
//  Tabbar
//
//  Created by lenbo lan on 2020/12/26.
//

import UIKit

class Router {
    
    typealias Submodules = ()
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
}

extension Router {
    
    static func tabs(usingSubmodules submodules: Submodules) -> LiaoliaoTabs {
        return ()
    }
    
}

extension Router: Routing {
    
}
