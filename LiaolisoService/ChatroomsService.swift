//
//  ChatroomsService.swift
//  LiaolisoService
//
//  Created by lenbo lan on 2021/1/10.
//

import RxSwift

import Models

public protocol ChatroomsAPI {
    func chatrooms() -> Single<[Chatroom]>
}

public final class ChatroomsService {
    
    private let httpService: ChatroomHttpService = ChatroomHttpService.shared
    
    public static let shared: ChatroomsService = ChatroomsService()
    
    private init() {}
    
}

extension ChatroomsService: ChatroomsAPI {
    
    public func chatrooms() -> Single<[Chatroom]> {
        ChatroomsHttpRouter.chatrooms.rx
            .request(withService: self.httpService)
            .responseJSON()
            .map { dataResponse in
                if let error = dataResponse.error {
                    print(error)
                    throw ChatroomError.custom(error: error.localizedDescription)
                }
                guard let statusCode = dataResponse.response?.statusCode,
                      statusCode == 200,
                      let data = dataResponse.data else {
                    throw ChatroomError.notFound(message: "Chatroom does not exist")
                }
                return try Chatrooms.init(data: data)
            }
            .asSingle()
    }
    
}
