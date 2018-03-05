//
//  Post.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import Foundation

public struct Post {
    public var content: String
    public var title: String
    public var postId: Int

    public init(postId: Int,
                content: String,
                title: String) {
        self.postId = postId
        self.content = content
        self.title = title
    }
}

extension Post: Equatable {

    public static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.title == rhs.title &&
            lhs.content == rhs.content &&
            lhs.postId == rhs.postId
    }

}
