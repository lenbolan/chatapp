//
//  Presenter.swift
//  Chatrooms
//
//  Created by lenbo lan on 2020/12/27.
//

import Foundation
import RxSwift
import RxCocoa

protocol Presentation {
    typealias Input = (
        email: Driver<String>,
        username: Driver<String>,
        password: Driver<String>,
        signup: Driver<Void>
    )
    typealias Output = (
        enableSignUp: Driver<Bool>, ()
    )
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
        let enableSignUpDriver = Driver.combineLatest(input.email.map({ $0.isEmail() }),
                                                      input.username.map( { !$0.isEmpty } ),
                                                      input.username.map( { !$0.isEmpty } )).map( { $0 && $1 && $2 } )
        
        return (
            enableSignUp: enableSignUpDriver, ()
        )
    }
    
    func process() {
        
    }
    
}
