//
//  ChatroomsService.swift
//  LiaolisoService
//
//  Created by lenbo lan on 2021/1/10.
//

import RxSwift
import Alamofire

import Models
import Utility

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
            .debug("chatrooms req", trimOutput: false)
            .responseJSON()
            .map(ResponseParser.parseThrowable(dataResponse:))
            .asSingle()
    }
    
}

class ResponseParser {
    
    static func parseThrowable<T: Codable>(dataResponse: DataResponse<Any, AFError>) throws -> T {
        if let error = dataResponse.error {
            print(error)
            throw ChatroomError.custom(error: error.localizedDescription)
        }
        
        let statusCode = dataResponse.response?.statusCode
        
        guard [200, 201].contains(statusCode), let data = dataResponse.data else {
            if statusCode == 404 {
                throw ChatroomError.notFound(message: String(describing: T.self))
            }
            if statusCode == 401 {
                throw ChatroomError.unauthorized(message: String(describing: T.self))
            }
            if statusCode == 400 {
                throw ChatroomError.badRequest
            }
            throw ChatroomError.internalError
        }
        
        do {
            return try newJSONDecoder().decode(T.self, from: data)
        } catch {
            throw ChatroomError.parsingFailed
        }
    }
    
}
