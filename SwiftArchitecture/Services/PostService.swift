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

    /// 通信用
    private let network = Network<Post>()


    /// 全部のPostを取得
    ///
    /// - Returns:
    func getPosts() -> Promise<[Post]> {
        return network.getItems(url: URLs.postURL)
    }


    /// PostIdで、Postオブジェクトを取得
    ///
    /// - Parameter postId: ポストのID
    /// - Returns: 
    func getPostByPostId(postId: Int) -> Promise<Post> {
        let params = ["postId": postId]
        return network.getItem(url: URLs.postURL, parameters: params)
    }
}
