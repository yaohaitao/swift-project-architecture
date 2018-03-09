//
//  DetailViewController.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import UIKit

protocol PostDetailViewControllerDelegate: class {

}

class PostDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!

    var viewModel: PostDetailPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        view.endEditing(true)
    }

    private func bind() {
        titleTextField.text = viewModel.title
        contentTextView.text = viewModel.content
    }
}

extension PostDetailViewController: PostDetailViewControllerDelegate {

}
