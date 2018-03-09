//
//  PostDetailPresenter.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import Foundation

class PostDetailPresenter {
    private let navigator: PostDetailNavigator
    private weak var delegate: PostDetailViewControllerDelegate?

    let title: String
    let content: String
    var post: Post

    required init(post: Post, navigator: PostDetailNavigator, delegate: PostDetailViewControllerDelegate) {
        self.post = post
        self.title = post.title
        self.content = post.content
        self.navigator = navigator
        self.delegate = delegate
    }
}
