//
//  PostViewController.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: PostViewModelProtocol! {
        didSet {
            self.viewModel.postsDidChanged = { _ in
                self.tableView.reloadData()
            }

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        viewModel.loadPosts()
    }

    private func configureTableView() {
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension

        tableView.dataSource = self.viewModel
    }
}
