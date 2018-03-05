//
//  PostService.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import Foundation

class PostService {

    var posts: [Post] = {
        var posts: [Post] = []

        for i in 1...5 {
            posts.append(Post(postId: i, content: "Post No.\(i) said that ...", title: "Post No.\(i)"))
        }

        return posts
    }()

    func listPosts() -> [Post] {
        return posts
    }

}
