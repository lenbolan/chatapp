//
//  Presenter.swift
//  Tabbar
//
//  Created by lenbo lan on 2020/12/26.
//

protocol Routing {
    
}

class Presenter: Presentation {
    
    weak var view: TabbarView?
    
    typealias UseCases = ()
    
    var useCases: UseCases
    
    init(useCases: UseCases) {
        self.useCases = useCases
    }
    
}
