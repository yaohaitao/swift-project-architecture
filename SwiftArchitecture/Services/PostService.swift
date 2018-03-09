//
//  PostService.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import Foundation
import PromiseKit

protocol PostService {

    /// 全部のPostを取得
    ///
    /// - Returns:
    func getPosts() -> Promise<[Post]>

    /// PostIdで、Postオブジェクトを取得
    ///
    /// - Parameter postId: ポストのID
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
