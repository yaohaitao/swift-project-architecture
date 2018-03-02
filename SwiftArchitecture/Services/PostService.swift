//
//  PostService.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import Foundation

class PostService {

    func listPosts() -> [Post] {

        var posts: [Post] = []

        for i in 1...5 {
            posts.append(Post(body: "Post No.\(i) said that ...", title: "Post No.\(i)"))
        }

        return posts
    }
}
