//
// Created by 姚海涛 on 2018/4/12.
// Copyright (c) 2018 yaohaitao. All rights reserved.
//

import PromiseKit

class LoginApi {

    private let network: Network<Result<User>>

    init(network: Network<Result<User>>) {
        self.network = network
    }

    func userLogin(user: User) -> Promise<Result<User>> {
        return network.postItem(url: URLs.loginURL, parameters: user.parameters)
    }
}
