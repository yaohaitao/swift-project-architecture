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

    private let network = Network<Post>()

    func getPosts() -> Promise<[Post]> {
        return network.getItems(url: URLs.postURL)
    }

    func getPostByPostId(postId: Int) -> Promise<Post> {
        let params = ["postId": postId]
        return network.getItem(url: URLs.postURL, parameters: params)
    }
}
