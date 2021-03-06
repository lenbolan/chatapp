//
//  HttpRouter.swift
//  LiaolisoService
//
//  Created by lenbo lan on 2020/12/28.
//

import Alamofire
import RxAlamofire
import RxSwift

public protocol HttpRouter {
    
    var baseUrlString: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var requestInterceptor: RequestInterceptor? { get }
    func body() throws -> Data?
    func request(usingHttpService httpService: HttpService) throws -> DataRequest
}

extension HttpRouter {
    
    public var parameters: Parameters? { return nil }
    public func body() throws -> Data? { return nil }
    public var requestInterceptor: RequestInterceptor? { return nil }
    
    func asURLRequest() throws -> URLRequest {
        var url = try baseUrlString.asURL()
        url.appendPathComponent(path)
        
        var request = try URLRequest(url: url, method: method, headers: headers)
        request.httpBody = try body()
        
        return request
    }
    
    public func request(usingHttpService httpService: HttpService) throws -> DataRequest {
        return try httpService.request(asURLRequest())
    }
    
}

public protocol ReactiveHttpRouter: HttpRouter, ReactiveCompatible { }

extension Reactive where Base: ReactiveHttpRouter {
    
    func request<Service: ReactiveHttpService>(withService service: Service) -> Observable<DataRequest> {
        do {
            return try service.rx.request(base.asURLRequest(), base.requestInterceptor)
        } catch {
            return .error(error)
        }
    }
    
}
