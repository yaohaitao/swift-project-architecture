//
//  ServiceProvider.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/8.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

final class ServiceProvider {
    
    private let apiProvider: ApiProvider

    init() {
        apiProvider = ApiProvider()
    }

    public func makePostService() -> PostService {
        return RemotePostService(api: apiProvider.makePostApi())
    }
}
