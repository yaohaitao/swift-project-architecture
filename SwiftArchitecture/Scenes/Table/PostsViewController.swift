//
//  PostsViewController.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/1.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PostsViewController: UITableViewController {

    // MARK: - 变量声明

    private let disposeBag = DisposeBag()
    var viewModel: PostsViewModel!

    // MARK: - View 生命周期

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bindViewModel()
    }

    // MARK: - 方法声明与实现

    @available(iOS 10.0, *)
    private func configure() {
        tableView.refreshControl = UIRefreshControl()
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    @available(iOS 10.0, *)
    private func bindViewModel() {
        assert(viewModel != nil)

        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()

        let pull = tableView.refreshControl!.rx
            .controlEvent(.valueChanged)
            .asDriver()

        let input = PostsViewModel.PostsViewInput(initView: Driver.merge(viewWillAppear, pull))

        let output = viewModel.transform(input: input)

        output.posts.drive(tableView.rx.items(cellIdentifier: PostsViewCell.reuseIndentifier,cellType: PostsViewCell.self))
        {   (row, elememt, cell) in
                cell.bind(elememt)
        }.disposed(by: disposeBag)

        output.isFetching
            .drive(tableView.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
    }
}
