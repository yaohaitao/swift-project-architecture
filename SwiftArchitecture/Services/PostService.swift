//
//  PostService.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import Foundation
import PromiseKit

class PostService {

//    private let api = NetworkProvider().makePostAPI()
    private let network = Network<Post>()

//    var posts: [Post] = {
//        var posts: [Post] = []
//
//        for i in 1...5 {
//            posts.append(Post(postId: i, content: "Post No.\(i) said that ...", title: "Post No.\(i)"))
//        }
//
//        return posts
//    }()
//
//    func listPosts() -> [Post] {
//        return posts
//    }

    func getPosts() -> Promise<[Post]> {
        return network.getItems(url: URLs.postURL)
    }

    func getPostByPostId(postId: Int) -> Promise<Post> {
        let params = ["postId": postId]
        return network.getItem(url: URLs.postURL, parameters: params)
    }
}
