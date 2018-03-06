//
//  PostCell.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    func bind(_ viewModel: PostCellViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.content
    }

}
