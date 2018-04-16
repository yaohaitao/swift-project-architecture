//
// Created by 姚海涛 on 2018/4/12.
// Copyright (c) 2018 yaohaitao. All rights reserved.
//

import SwiftyJSON

/// サーバーからのデータカプセル化（Demo）
struct Result<ModelType: BaseModel>: Modelable {

    var status: Int
    var message: String
    var data: ModelType?

    init(status: Int, message: String, data: ModelType? = nil) {
        self.status = status
        self.message = message
        self.data = data
    }

    init(fromJSON json: JSON) throws {
        guard let status = json["status"].int,
              let message = json["message"].string else {
            throw SAError.callApiError(reason: .invalidJsonToObject(json: json))
        }

        if let data = try? ModelType(fromJSON: json["data"]) {
            self.data = data
        }

        self.status = status
        self.message = message
    }
}
