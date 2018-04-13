//
// Created by 姚海涛 on 2018/4/12.
// Copyright (c) 2018 yaohaitao. All rights reserved.
//

import PromiseKit

protocol LoginService {

    func userLogin(user: User) -> Promise<Result<User>>

}

class RemoteLoginService: LoginService {

    private let api: LoginApi

    required init(api: LoginApi) {
        self.api = api
    }

    func userLogin(user: User) -> Promise<Result<User>> {
//        return api.userLogin(user: user)
        return Promise<Result<User>> { resolver in
            if user.username == "admin", user.password == "admin" {
                let result = Result<User>(status: 1, message: "Login successfully", data: user)
                resolver.fulfill(result)
            } else {
                let result = Result<User>(status: 0, message: "Error username or password", data:
                nil)
                resolver.fulfill(result)
            }
         }
    }
}
