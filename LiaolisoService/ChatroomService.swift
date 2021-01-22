//
//  ChatroomService.swift
//  LiaolisoService
//
//  Created by lenbo lan on 2021/1/22.
//

import RxSwift
import RxCocoa

import Models

public protocol ChatroomAPI {
    func create(usingChatroom chatroom: Chatroom) -> Single<Chatroom>
}

public final class ChatroomService {
    
    private let httpService: ChatroomHttpService = ChatroomHttpService.shared
    
    public static let shared: ChatroomService = ChatroomService()
    private init() { }
    
}

extension ChatroomService: ChatroomAPI {
    
    public func create(usingChatroom chatroom: Chatroom) -> Single<Chatroom> {
        ChatroomHttpRouter.create(chatroom: chatroom).rx
            .request(withService: httpService)
            .responseJSON()
            .map(ResponseParser.parseThrowable(dataResponse:))
            .asSingle()
    }
    
}
