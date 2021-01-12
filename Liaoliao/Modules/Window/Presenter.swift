//
//  Presenter.swift
//  Window
//
//  Created by lenbo lan on 2020/12/17.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

enum RouteTo {
    case login
    case signup
    case chatrooms
}

protocol Routing {
    func routeToLanding() -> Single<Void>
    func routeToLogin() -> Single<RouteTo>
    func routeToSignup() -> Single<RouteTo>
    func routeToChatrooms() -> Single<RouteTo>
}

class Presenter: Presentation {
    
    private let bag = DisposeBag()
    private let router: Routing
    
    typealias UseCases = (
        validate: () -> Single<Bool>, ()
    )
    
    private let useCases: UseCases
    
    private let routeToRelay: PublishRelay<RouteTo> = PublishRelay()
    private lazy var routeToDriver: Driver<RouteTo> = self.routeToRelay.asDriver(onErrorDriveWith: .never())
    
    init(router: Routing, useCases: UseCases) {
        self.router = router
        self.useCases = useCases
        process()
    }
    
}

private extension Presenter {
    
    func process() {
        let validate = self.useCases.validate()
            .asDriver(onErrorJustReturn: false)
            .debug("validate", trimOutput: false)
        
        validate
            .filter({ !$0 })
            .map({ _ in })
            .asObservable()
            .flatMap(self.router.routeToLanding)
            .flatMap(self.router.routeToLogin)
            .map(self.routeToRelay.accept)
            .asDriver(onErrorDriveWith: .never())
            .drive()
            .disposed(by: bag)
        
        validate
            .filter({ $0 })
            .map({ _ in })
            .asObservable()
            .flatMap(self.router.routeToChatrooms)
            .map(self.routeToRelay.accept)
            .asDriver(onErrorDriveWith: .never())
            .drive()
            .disposed(by: bag)
        
        self.router.routeToLanding()
            .flatMap(self.router.routeToLogin)
            .map(self.routeToRelay.accept)
            .asDriver(onErrorDriveWith: .never())
            .drive()
            .disposed(by: bag)
        
        self.routeToDriver
            .debug("routeToDriver", trimOutput: false)
            .filter({
                guard case .signup = $0 else { return false }
                return true
            })
            .map({ _ in ()})
            .asObservable()
            .flatMap(self.router.routeToSignup)
            .map(self.routeToRelay.accept)
            .asDriver(onErrorDriveWith: .never())
            .drive()
            .disposed(by: bag)
        
        self.routeToDriver
            .debug("routeToDriver", trimOutput: false)
            .filter({
                guard case .login = $0 else { return false }
                return true
            })
            .map({ _ in ()})
            .asObservable()
            .flatMap(self.router.routeToLogin)
            .map(self.routeToRelay.accept)
            .asDriver(onErrorDriveWith: .never())
            .drive()
            .disposed(by: bag)
        
        self.routeToDriver
            .debug("routeToDriver", trimOutput: false)
            .filter({
                guard case .chatrooms = $0 else { return false }
                return true
            })
            .map({ _ in ()})
            .asObservable()
            .flatMap(self.router.routeToChatrooms)
            .map(self.routeToRelay.accept)
            .asDriver(onErrorDriveWith: .never())
            .drive()
            .disposed(by: bag)
    }
    
}
