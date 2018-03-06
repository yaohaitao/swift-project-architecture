//
//  PostsNavigator.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import UIKit

class PostNavigator {

    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let service: PostService

    init(service: PostService,
         navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.service = service
        self.navigationController = navigationController
        self.storyBoard = storyBoard
    }

    func toPostView() {
        let vc = storyBoard.instantiateViewController(ofType: PostViewController.self)
        vc.viewModel = PostViewModel(service: service, navigator: self, delegate: vc)
        vc.navigationItem.title = "Post"

        navigationController.pushViewController(vc, animated: true)
    }

    func toPostDetailView(_ post: Post) {
        let vc = storyBoard.instantiateViewController(ofType: PostDetailViewController.self)
        let postDetailNavigator = PostDetailNavigator(navigationController: navigationController)
        vc.viewModel = PostDetailViewModel(post: post, navigator: postDetailNavigator, delegate: vc)
        vc.navigationItem.title = post.title

        navigationController.pushViewController(vc, animated: true)
    }
}