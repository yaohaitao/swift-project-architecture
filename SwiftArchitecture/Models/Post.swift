//
//  Post.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import SwiftyJSON

struct Post: BaseModel {

    var content: String
    var title: String
    var postId: Int
    var parameters: [String: Any] {
        return [
            Fields.Post.postId: postId,
            Fields.Post.title: title,
            Fields.Post.content: content
        ]
    }

    init(postId: Int,
         content: String,
         title: String) {
        self.postId = postId
        self.content = content
        self.title = title
    }

    init(fromJSON json: JSON) throws {
        guard let postId = json[Fields.Post.postId].int,
              let title = json[Fields.Post.title].string,
              let content = json[Fields.Post.content].string else {
            throw SAError.callApiError(reason: SAError.CallApiErrorReason.invalidJsonToObject(json: json))
        }

        self.postId = postId
        self.title = title
        self.content = content
    }
}

extension Post: Equatable {

    public static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.title == rhs.title &&
                lhs.content == rhs.content &&
                lhs.postId == rhs.postId
    }
}
