//
//  PostViewController.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import UIKit

protocol PostViewControllerDelegate: class {

    /// テーブルビューは全てのデータを再読み込む
    func tableViewReloadData()

    /// デーブルビューから、指定されたセルを削除
    ///
    /// - Parameter indexPaths: 指定されたセルのインデックス
    func deleteRows(indexPaths: [IndexPath])
}

class PostViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!

    // MARK: - 変数の定義
    var viewModel: PostPresenter!

    // MARK: - Viewのライフサイクル
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.loadPosts()
    }

    // MARK: - プライペート方法の定義
    private func configureTableView() {

        tableView.register(ofType: PostCell.self)

        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension

        tableView.dataSource = self.viewModel
        tableView.delegate = self.viewModel
    }
}

// MARK: - Delegateの実装
extension PostViewController: PostViewControllerDelegate {

    func tableViewReloadData() {
        tableView.reloadData()
    }

    func deleteRows(indexPaths: [IndexPath]) {
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }

}
