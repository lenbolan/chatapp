//
//  ChatroomWebsocketService.swift
//  LiaolisoService
//
//  Created by lenbo lan on 2020/12/19.
//

import SocketIO
import RxSwift
import RxRelay

import Models

protocol WebsocketResponseAPI {
    var socketResponse: Observable<ChatroomWebsocket.Response> { get }
}

public protocol AccountWebsocketAPI {
    func setupConnection(usingSocketUrl: URL, authToken: String) -> Single<Void>
}

public class ChatroomWebsocketService: WebsocketResponseAPI {
    
    private let socketUrl: String
    private var socketManager: SocketManager!
    private var socket: SocketIOClient!
    
    private let socketResponseRelay: PublishRelay<ChatroomWebsocket.Response> = PublishRelay()
    public lazy var socketResponse: Observable<ChatroomWebsocket.Response> = self.socketResponseRelay.asObservable()
    
    public init(socketUrl: String) {
        self.socketUrl = socketUrl
    }
    
    deinit {
        self.socket.disconnect()
    }
    
}

extension ChatroomWebsocketService: AccountWebsocketAPI {
    
    public func setupConnection(usingSocketUrl url: URL, authToken: String) -> Single<Void> {
        
        return Single.create { [weak self] (single) -> Disposable in
            
            guard let `self` = self else { return Disposables.create() }
            let param: [String: Any] = ["token": authToken]
            self.socketManager = SocketManager(socketURL: url, config: [.log(true), .compress])
            self.socketManager.config = SocketIOClientConfiguration(arrayLiteral: .connectParams(param), .secure(false))
            self.socket = self.socketManager.defaultSocket
            
            self.socket.connect()
            
            self.setupSocketResponse(authToken: authToken)
            
            single(.success(()))
            
            return Disposables.create()
        }
    }
    
}

struct ChatSocket {
    
    struct Request {
        static let authenticate = "authenticate"
    }
    
    struct Response {
        static let connect = "connect"
        static let authenticated = "authenticated"
        static let unauthorized = "unauthorized"
    }
    
}

private extension ChatroomWebsocketService {
    
    func setupSocketResponse(authToken: String) {
        let param: [String: Any] = ["token": authToken]
        self.socket.on(ChatSocket.Response.connect) { [weak self] (dataArray, socketAck) in
            self?.socket.emit(ChatSocket.Request.authenticate, param)
        }
        
        self.socket.on(ChatSocket.Response.authenticated) { [weak self] (dataArray, socketAck) in
            print("User is authenticated")
        }
        
        self.socket.on(ChatSocket.Response.unauthorized) { [weak self] (dataArray, socketAck) in
            print("User is unauthorized")
        }
    }
    
}
