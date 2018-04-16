//
//  ApiProvider.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/8.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

final class ApiProvider {

    public func makePostApi() -> PostApi {
        let network = Network<Post>()
        return PostApi(network: network)
    }

    public func makeLoginApi() -> LoginApi {
        let network = Network<Result<User>>()
        return LoginApi(network: network)
    }
}
