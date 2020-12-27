//
//  Presenter.swift
//  Chatrooms
//
//  Created by lenbo lan on 2020/12/27.
//

import Foundation

protocol Presentation {
    typealias Input = ()
    typealias Output = ()
    typealias Producer = (Presentation.Input) -> Presentation
    
    var input: Input { get }
    var output: Output { get }
}

class Presenter: Presentation {
    var input: Input
    var output: Output
    
    typealias UseCases = (
        input: (),
        output: ()
    )
    
    private let dependencies: Dependencies
    private let router: Routing
    private let useCases: UseCases
    
    typealias Dependencies = (router: Routing, useCases: UseCases)
    
    init(input: Input, dependencies: Dependencies) {
        self.input = input
        self.output = Presenter.output(input: self.input)
        self.dependencies = dependencies
        self.router = dependencies.router
        self.useCases = dependencies.useCases
        self.process()
    }
    
}

private extension Presenter {
    
    static func output(input: Input) -> Output {
        return ()
    }
    
    func process() {
        
    }
    
}
