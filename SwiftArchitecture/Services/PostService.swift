//
//  PostService.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import PromiseKit

protocol PostService {
    /// 获取全部帖子
    ///
    /// - Returns:
    func getPosts() -> Promise<[Post]>

    /// 通过 PostId 获取帖子
    ///
    /// - Parameter postId: 帖子ID
    /// - Returns:
    func getPost(by postId: Int)  -> Promise<Post>
}

class RemotePostService: PostService {
    /// 通信用
    private let api: PostApi

    required init(api: PostApi) {
        self.api = api
    }

    func getPosts() -> Promise<[Post]> {
        return api.fetchPosts()
    }

    func getPost(by postId: Int) -> Promise<Post> {
        return api.fetchPostByPostId(postId: postId)
    }
}
