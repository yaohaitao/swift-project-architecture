//
//  PostsViewModel.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/1.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

//class PostsViewModel: ViewModelType {
class PostsViewModel {

    // 定义变量
    private let postsService: PostsService

    // 初始化方法
    init(postsService: PostsService) {
        self.postsService = postsService
    }

}

// MARK: - 协议实现
extension PostsViewModel: ViewModelType {

    typealias Input = PostsViewInput
    typealias Output = PostsViewOutput

    struct PostsViewInput {
        let initView: Driver<Void>
    }

    struct PostsViewOutput {
        let isFetching: Driver<Bool>
        let posts: Driver<[PostsCellViewModel]>
        let error: Driver<Error>

    }

    func transform(input: PostsViewModel.PostsViewInput) -> PostsViewModel.PostsViewOutput {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()

        let posts = input.initView.flatMapLatest { _ in
            return self.postsService.listPosts()
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
                .map { $0.map { PostsCellViewModel(with: $0) } }
        }

        let isFetching = activityIndicator.asDriver()
        let error = errorTracker.asDriver()

        return PostsViewOutput(isFetching: isFetching,
                               posts: posts,
                               error: error)
    }
}
