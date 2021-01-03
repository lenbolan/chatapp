//
//  ChatroomHttpService.swift
//  LiaolisoService
//
//  Created by lenbo lan on 2021/1/1.
//

import Alamofire

public final class ChatroomHttpService: ReactiveHttpService {
    
    public static let shared: ChatroomHttpService = ChatroomHttpService()
    
    public var session: Session
    
    private init() {
        self.session = Session.default
    }
    
    public func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        self.session.request(urlRequest)
    }
    
}
