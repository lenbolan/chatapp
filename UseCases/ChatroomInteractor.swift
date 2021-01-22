//
//  ChatroomInteractor.swift
//  UseCases
//
//  Created by lenbo lan on 2021/1/22.
//

import RxSwift
import RxCocoa

import LiaolisoService
import Models

public final class ChatroomInteractor {
    
    private let chatroomService: ChatroomAPI
    
    init(chatroomService: ChatroomAPI) {
        self.chatroomService = chatroomService
    }
    
}

public extension ChatroomInteractor {
    
    func createChatroom(usingChatroom chatroom: Chatroom) -> Single<Void> {
        return self.chatroomService.create(usingChatroom: chatroom).map({ chatroom in
            print("Chatroom created = \(chatroom)")
            return ()
        })
    }
    
}
