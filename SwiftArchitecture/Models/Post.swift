//
//  Post.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/1.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import Foundation

public struct Post {
    public let body: String
    public let title: String

    public init(body: String,
                title: String) {
        self.body = body
        self.title = title
    }
}

extension Post: Equatable {

    public static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.title == rhs.title &&
            lhs.body == rhs.body
    }

}
