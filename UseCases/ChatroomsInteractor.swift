//
//  ChatroomsInteractor.swift
//  UseCases
//
//  Created by lenbo lan on 2021/1/10.
//

import RxSwift
import RxRelay

import LiaolisoService
import Models

public final class ChatroomsInteractor {
    
    private let chatroomsRelay: BehaviorRelay<[Chatroom]> = BehaviorRelay(value: [])
    public lazy var chatrooms: Observable<[Chatroom]> = self.chatroomsRelay.asObservable()
    private let chatroomsService: ChatroomsAPI
    
    init(chatroomsService: ChatroomsAPI) {
        self.chatroomsService = chatroomsService
    }
    
}

public extension ChatroomsInteractor {
    
    func fetchChatrooms() -> Completable {
        return self.chatroomsService
            .chatrooms()
            .map({ [chatroomsRelay] chatrooms in
                chatroomsRelay.accept(chatroomsRelay.value + chatrooms)
            })
            .asCompletable()
    }
    
}
