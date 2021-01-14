//
//  HttpService.swift
//  LiaolisoService
//
//  Created by lenbo lan on 2020/12/28.
//

import Alamofire
import RxAlamofire
import RxSwift

public protocol HttpService {
    
    var session: Session { get }
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest
    
}

public protocol ReactiveHttpService: HttpService, ReactiveCompatible {
    
}

extension Reactive where Base: ReactiveHttpService {
    
    public func request(_ urlRequest: URLRequestConvertible,
                        _ requestInterceptor: RequestInterceptor?) -> Observable<DataRequest> {
        
        return base.session.rx
            .request(urlRequest: urlRequest, interceptor: requestInterceptor)
            .validate(statusCode: 200..<400)
        
    }
    
}
