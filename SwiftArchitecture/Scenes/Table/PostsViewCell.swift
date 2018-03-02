//
//  PostsViewCell.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/1.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import UIKit

class PostsViewCell: UITableViewCell {

    func bind(_ viewModel: PostsCellViewModel) {
        self.textLabel?.text = viewModel.title
        self.detailTextLabel?.text = viewModel.subtitle
    }
}
