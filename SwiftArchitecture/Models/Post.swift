//
//  Post.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import SwiftyJSON

public struct Post {
    var content: String
    var title: String
    var postId: Int

    init(postId: Int,
         content: String,
         title: String) {
        self.postId = postId
        self.content = content
        self.title = title
    }
}

extension Post: Modelable {
    init(fromJSON json: JSON) throws {
        guard let postId = json["postId"].int,
            let title = json["title"].string,
            let content = json["content"].string else {
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
