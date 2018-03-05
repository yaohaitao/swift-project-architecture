//
//  PostDetailViewModel.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import Foundation

class PostDetailViewModel {

    private let navigator: PostDetailNavigator
    private weak var delegate: PostDetailViewControllerDelegate?
    var post: Post

    required init(post: Post, navigator: PostDetailNavigator, delegate: PostDetailViewControllerDelegate) {
        self.post = post
        self.navigator = navigator
        self.delegate = delegate
    }

//    func updatePost(title: String, content: String) {
//        post.title = title
//        post.content = content
//    }

}
