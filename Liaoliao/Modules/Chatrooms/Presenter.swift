//
//  Presenter.swift
//  Chatrooms
//
//  Created by lenbo lan on 2020/12/27.
//

import Foundation
import RxSwift

import Models

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
    
    private let bag = DisposeBag()
    
    typealias UseCases = (
        input: (
            fetchChatrooms: () -> Completable, ()
        ),
        output: (
            chatrooms: Observable<[Chatroom]>, ()
        )
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
        self.useCases.input
            .fetchChatrooms()
            .debug("fetchChatrooms", trimOutput: false)
            .subscribe()
            .disposed(by: bag)
        
        self.useCases.output.chatrooms
            .debug("chatrooms", trimOutput: false)
            .subscribe()
            .disposed(by: bag)
    }
    
}
