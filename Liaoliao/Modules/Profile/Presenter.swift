//
//  Presenter.swift
//  Chatrooms
//
//  Created by lenbo lan on 2020/12/27.
//

import Foundation
import RxSwift
import RxCocoa

import Models

protocol Presentation {
    typealias Input = (
        onLogout: Driver<Void>, ()
    )
    typealias Output = (
        username: Driver<String>,
        email: Driver<String>
    )
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
            logout: () -> Single<()>, ()
        ),
        output: (
            profileUser: Observable<User>, ()
        )
    )
    
    private let dependencies: Dependencies
    private let router: Routing
    private let useCases: UseCases
    
    typealias Dependencies = (router: Routing, useCases: UseCases)
    
    init(input: Input, dependencies: Dependencies) {
        self.input = input
        self.dependencies = dependencies
        self.router = dependencies.router
        self.useCases = dependencies.useCases
        self.output = Presenter.output(input: self.input, useCases: self.useCases)
        self.process()
    }
    
}

private extension Presenter {
    
    static func output(input: Input, useCases: UseCases) -> Output {
        let profileUser = useCases.output.profileUser.map( { $0 } ).asDriver(onErrorDriveWith: .never())
        return (
            username: profileUser.map({ $0.username ?? "" }),
            email: profileUser.map({ $0.email })
        )
    }
    
    func process() {
        self.input.onLogout
            .asObservable()
            .flatMap({ [useCases] _ in
                useCases.input.logout()
            })
            .map({ [router] _ in
                router.routeToRoot()
            })
            .asDriver(onErrorDriveWith: .never())
            .drive()
            .disposed(by: bag)
    }
    
}
