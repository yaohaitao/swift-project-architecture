//
//  UITableView+DequeueReusableCell.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/1.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import UIKit

extension UITableViewCell: Reusable {}

extension UITableView {
    func dequeueReusableCell<T>(ofType cellType: T.Type = T.self, at indexPath: IndexPath)
        -> T where T: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseIndentifier,
                                             for: indexPath) as? T else {
                                                fatalError()
        }
        return cell
    }
}
