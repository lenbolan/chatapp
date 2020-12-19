//
//  Presenter.swift
//  ChatroomLogin
//
//  Created by lenbo lan on 2020/12/19.
//

import Foundation
import RxSwift
import RxCocoa

protocol Routing {
    
}

class Presenter: Presentation {
    
    typealias UseCases = (
    
    )
    
    var input: Input
    var output: Output
    
    private let useCases: UseCases
    private let router: Routing
    
    init(input: Input,
         router: Routing,
         useCases: UseCases) {
        self.input = input
        self.output = Presenter.output(input: self.input)
        self.router = router
        self.useCases = useCases
    }
    
}

private extension Presenter {
    
    static func output(input: Input) ->  Output {
        
        let enableLoginDriver = Driver.combineLatest(
            input.username.map({ !$0.isEmpty }),
            input.email.map( { $0.isEmail() })
        ).map( { $0 && $1 })
        
        return (
            enableLogin: enableLoginDriver, ()
        )
    }
    
    func process() {
        
    }
    
}
