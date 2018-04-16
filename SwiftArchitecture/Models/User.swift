//
// Created by 姚海涛 on 2018/4/12.
// Copyright (c) 2018 yaohaitao. All rights reserved.
//

import SwiftyJSON

struct User: BaseModel {

    var username: String
    var password: String
    var parameters: [String: Any] {
        return [
            Fields.User.username: username,
            Fields.User.password: password
        ]
    }

    init(username: String, password: String) {
        self.username = username
        self.password = password
    }

    init(fromJSON json: JSON) throws {
        guard let username = json[Fields.User.username].string,
              let password = json[Fields.User.password].string else {
            throw SAError.callApiError(reason: .invalidJsonToObject(json: json))
        }

        self.username = username
        self.password = password
    }
}
