//
//  Reusable.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import UIKit

protocol Reusable {
    static var reuseID: String {get}
}

extension Reusable {
    static var reuseID: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}

extension UIViewController: Reusable {}

extension UITableView {
    func dequeueReusableCell<T>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) ->
        T where T: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseID,
                                             for: indexPath) as? T else {
                                                fatalError()
        }
        return cell
    }
}

extension UIStoryboard {
    func instantiateViewController<T>(ofType type: T.Type = T.self) -> T where T: UIViewController {
        guard let viewController = instantiateViewController(withIdentifier: type.reuseID) as? T else {
            fatalError()
        }
        return viewController
    }
}
