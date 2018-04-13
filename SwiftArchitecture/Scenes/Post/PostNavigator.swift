//
//  PostNavigator.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import UIKit

class PostNavigator {

    private let navigationController: UINavigationController
    private let service: PostService

    init(service: PostService,
         navigationController: UINavigationController) {
        self.service = service
        self.navigationController = navigationController
    }

    func toPostView() {
        let vc = PostViewController()
        vc.presenter = PostPresenter(service: service, navigator: self, delegate: vc)
        vc.navigationItem.title = "Post"

        navigationController.pushViewController(vc, animated: true)
    }

    func toPostDetailView(_ post: Post) {
        let postDetailNavigator = PostDetailNavigator(navigationController: navigationController)

        let vc = PostDetailViewController()
        vc.viewModel = PostDetailPresenter(post: post, navigator: postDetailNavigator, delegate: vc)
        vc.navigationItem.title = post.title

        navigationController.pushViewController(vc, animated: true)
    }
}
