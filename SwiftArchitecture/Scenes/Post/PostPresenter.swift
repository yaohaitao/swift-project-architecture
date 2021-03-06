//
//  PostPresenter.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import UIKit

class PostPresenter: NSObject {
    // MARK: - 定义变量
    private let service: PostService
    private let navigator: PostNavigator
    private weak var delegate: PostViewControllerDelegate?
    private var posts: [Post]? {
        didSet {
            guard
                let oldValue = oldValue,
                let newValue = posts
                else {
                    delegate?.tableViewReloadData()
                    return
            }

            if oldValue.elementsEqual(newValue) {
                return
            }

            if oldValue.count < newValue.count {
                delegate?.tableViewReloadData()
            }
        }
    }

    // MARK: - 初始化
    required init(service: PostService, navigator: PostNavigator, delegate: PostViewControllerDelegate) {
        self.service = service
        self.navigator = navigator
        self.delegate = delegate
    }

    // MARK: - 方法
    func loadPosts() {
        service.getPosts()
            .done { posts in
                self.posts = posts
            }.catch { error in
                if case let SAError.callApiError(reason: .internetConnectFailed(message: message)) = error {
                    // 网络连接错误
                    print(message)
                } else {
                    print(error.localizedDescription)
                }
        }
    }

    // MARK: - 私有方法
    private func getCurrentPost(of indexPath: IndexPath) -> Post {
        guard let post = posts?[indexPath.row] else {
            fatalError()
        }
        return post
    }

}

// MARK: - Ext: Table View Data Source
extension PostPresenter: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = posts?.count else { return 0 }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: PostCell.self, at: indexPath)
        let post = getCurrentPost(of: indexPath)
        let viewModel = PostCellPresenter(with: post)
        cell.bind(viewModel)
        return cell
    }
}

// MARK: - Ext: Table View Delegate
extension PostPresenter: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = getCurrentPost(of: indexPath)
        self.navigator.toPostDetailView(post)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            posts?.remove(at: indexPath.row)
            delegate?.deleteRows(indexPaths: [indexPath])
        }
    }

    // Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let header = TouchIdSettingView(frame: tableView.rectForHeader(inSection: section))
        header.touchIdSwitch.isOn = DefaultsValues.enableTouchIdLogin
        return header
    }

}
