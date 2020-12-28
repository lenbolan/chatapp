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
    func routeToWindow()
}

class Presenter: Presentation {
    
    typealias UseCases = (
        login: (_ username: String, _ email: String) -> Single<()>,
        ()
    )
    
    var input: Input
    var output: Output
    
    private let useCases: UseCases
    private let router: Routing
    
    private let bag = DisposeBag()
    
    init(input: Input,
         router: Routing,
         useCases: UseCases) {
        self.input = input
        self.output = Presenter.output(input: self.input)
        self.router = router
        self.useCases = useCases
        self.process()
    }
    
}

private extension Presenter {
    
    static func output(input: Input) ->  Output {
        
        let enableLoginDriver = Driver.combineLatest(
            input.email.map( { $0.isEmail() }),
            input.password.map({ !$0.isEmpty })
        ).map( { $0 && $1 })
        
        return (
            enableLogin: enableLoginDriver, ()
        )
    }
    
    func process() {
        self.input.login
            .withLatestFrom(Driver.combineLatest(self.input.email, self.input.password))
            .asObservable()
            .flatMap({ [useCases] (username, email) in
                useCases.login(username, email)
            })
            .map({ [router] (_) in
                print("Login successful for user")
                router.routeToWindow()
            })
            .asDriver(onErrorDriveWith: .never())
            .drive()
            .disposed(by: bag)
    }
    
}
