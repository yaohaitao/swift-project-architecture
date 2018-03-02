//
//  PostViewModel.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import UIKit

protocol PostViewModelProtocol: UITableViewDataSource {

    var posts: [Post]? { get }

    var postsDidChanged: ((PostViewModelProtocol) -> Void)? { get set }

    init(postService: PostService)

    func loadPosts()

}

class PostViewModel: NSObject, PostViewModelProtocol {

    private let postService: PostService

    var posts: [Post]? {
        didSet {
            self.postsDidChanged?(self)
        }
    }

    var postsDidChanged: ((PostViewModelProtocol) -> Void)?

    required init(postService: PostService) {
        self.postService = postService
    }

    func loadPosts() {
       posts = postService.listPosts()
    }

}

extension PostViewModel {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = posts?.count else { return 0 }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: PostCell.self, at: indexPath)
        guard let post = posts?[indexPath.row] else {
            fatalError()
        }
        let viewModel = PostCellViewModel(with: post)
        cell.bind(viewModel)
        return cell
    }

}
