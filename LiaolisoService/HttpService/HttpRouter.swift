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
    func body() throws -> Data?
    func request(usingHttpService httpService: HttpService) throws -> DataRequest
}

extension HttpRouter {
    
    var parameters: Parameters? { return nil }
    
    func body() throws -> Data? { return nil }
    
    func asURLRequest() throws -> URLRequest {
        var url = try baseUrlString.asURL()
        url.appendPathComponent(path)
        
        var request = try URLRequest(url: url, method: method, headers: headers)
        request.httpBody = try body()
        
        return request
    }
    
    func request(usingHttpService httpService: HttpService) throws -> DataRequest {
        return try httpService.request(asURLRequest())
    }
    
}

public protocol ReactiveHttpRouter: HttpRouter, ReactiveCompatible { }

extension Reactive where Base: ReactiveHttpRouter {
    
    func request<Service: ReactiveHttpService>(withService service: Service) throws -> Observable<DataRequest> {
        return try service.rx.request(base.asURLRequest())
    }
    
}
