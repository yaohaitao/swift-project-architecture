//
//  PostViewController.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import UIKit

protocol PostViewControllerDelegate: class {
    /// 刷新 Table View
    func tableViewReloadData()

    /// 删除指定的行
    ///
    /// - Parameter indexPaths: 行的索引
    func deleteRows(indexPaths: [IndexPath])
}

class PostViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!

    // MARK: - 变量定义
    var viewModel: PostPresenter!

    // MARK: - View 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.loadPosts()
    }

    // MARK: - 私有方法
    private func configureTableView() {
        tableView.register(ofType: PostCell.self)

        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension

        tableView.dataSource = self.viewModel
        tableView.delegate = self.viewModel
    }
}

// MARK: - 实现Delegate
extension PostViewController: PostViewControllerDelegate {
    
    func tableViewReloadData() {
        tableView.reloadData()
    }

    func deleteRows(indexPaths: [IndexPath]) {
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
}
