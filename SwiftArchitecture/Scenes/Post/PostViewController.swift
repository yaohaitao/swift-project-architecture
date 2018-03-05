//
//  PostViewController.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import UIKit

protocol PostViewControllerDelegate: class {

    func tableViewReloadData()

    func deleteRows(indexPaths: [IndexPath])
}

class PostViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: PostViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.loadPosts()
    }

    private func configureTableView() {
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension

        tableView.dataSource = self.viewModel
        tableView.delegate = self.viewModel
    }
}

extension PostViewController: PostViewControllerDelegate {

    func tableViewReloadData() {
        tableView.reloadData()
    }

    func deleteRows(indexPaths: [IndexPath]) {
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }

}
