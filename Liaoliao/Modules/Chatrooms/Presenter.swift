//
//  Presenter.swift
//  Chatrooms
//
//  Created by lenbo lan on 2020/12/27.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

import Models

protocol Presentation {
    typealias Input = (
        onCreateTap: Driver<Void>, ()
    )
    typealias Output = (
        sections: Driver<[ChatroomsSection]>, ()
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
            fetchChatrooms: () -> Completable, ()
        ),
        output: (
            chatrooms: Observable<Set<Chatroom>>, ()
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
        self.output = Presenter.output(input: self.input,
                                       useCases: self.useCases)
        self.process()
    }
    
}

private extension Presenter {
    
    static func output(input: Input, useCases: UseCases) -> Output {
        let chatrooms = useCases.output.chatrooms
            .map(ChatroomViewModel.build(models:))
            .map(ChatroomsSection.sections(usingItems:))
            .asDriver(onErrorJustReturn: [])
        
        return (
            sections: chatrooms, ()
        )
    }
    
    func process() {
        self.useCases.input
            .fetchChatrooms()
            .debug("fetchChatrooms", trimOutput: false)
            .subscribe()
            .disposed(by: bag)
        
        self.input.onCreateTap
            .map({ [router] (_) in
                router.routeToCreate()
            })
            .drive()
            .disposed(by: bag)
    }
    
}

struct ChatroomsSection {
    var header: Int
    var items: [Item]
}

extension ChatroomsSection: AnimatableSectionModelType {
    typealias Item = ChatroomViewModel
    typealias Identity = Int
    
    var identity: Int {
        return header
    }
    
    init(original: ChatroomsSection, items: [Item]) {
        self = original
        self.items = items
    }
}

extension ChatroomsSection {
    init(items: [Item]) {
        self.init(header: 0, items: items)
    }
    
    static func sections(usingItems items: [Item]) -> [ChatroomsSection] {
        return [ChatroomsSection(items: items)]
    }
}

struct ChatroomViewModel {
    let id: String
    let title: String
    let timestamp: BehaviorRelay<String> = BehaviorRelay(value: "")
    let statusMessage: BehaviorRelay<String> = BehaviorRelay(value: "")
    let unreadCount: BehaviorRelay<Int> = BehaviorRelay(value: 0)
}

extension ChatroomViewModel {
    init(usingModel model: Chatroom) {
        self.id = model.id ?? ""
        self.title = model.name
        self.statusMessage.accept(model.subject)
        self.timestamp.accept(model.createdAt?.converToDate()?.timeAgoSinceNow() ?? "Unknown")
    }
    
    static func build(models: Set<Chatroom>) -> [ChatroomViewModel] {
        return models.compactMap({ ChatroomViewModel(usingModel: $0) })
    }
}

extension ChatroomViewModel: IdentifiableType, Equatable {
    typealias Identity = String
    
    var identity: String {
        return id
    }
    
    static func == (lhs: ChatroomViewModel, rhs: ChatroomViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
