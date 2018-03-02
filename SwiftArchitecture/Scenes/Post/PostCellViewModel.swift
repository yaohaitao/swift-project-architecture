//
//  PostCellViewModel.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import Foundation

final class PostCellViewModel {
    let title: String
    let subtitle: String
    let post: Post

    init (with post: Post) {
        self.post = post
        self.title = post.title
        self.subtitle = post.body
    }
}
