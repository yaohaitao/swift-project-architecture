//
//  PostApi.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import Alamofire
import PromiseKit

// 使っていない
class PostApi {

    /// 通信用
    private let network: Network<Post>

    init(network: Network<Post>) {
        self.network = network
    }

    func fetchPosts() -> Promise<[Post]> {
        return network.getItems(url: URLs.postURL)
    }

    func fetchPostByPostId(postId: Int) -> Promise<Post> {
        let params = ["postId": postId]
        return network.getItem(url: URLs.postURL, parameters: params)
    }
}
