//
//  Presenter.swift
//  Window
//
//  Created by lenbo lan on 2020/12/17.
//

import Foundation

protocol Routing {
    func routeToLanding()
    func routeToLogin()
}

class Presenter: Presentation {
    
    private let router: Routing
    
    init(router: Routing) {
        self.router = router
        process()
    }
    
}

private extension Presenter {
    
    func process() {
        self.router.routeToLanding()
    }
    
}
