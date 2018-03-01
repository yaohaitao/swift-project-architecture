//
//  UIStoryboard+InstantiateVC.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/1.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import UIKit

// 让 UIViewController 实现 Resuable
extension UIViewController: Reusable {}

// 为 UIStoryboard 扩充 instantiateViewController:ofType 方法
extension UIStoryboard {
    func instantiateViewController<T: Reusable>(ofType type: T.Type = T.self) -> T {
        guard let vc = instantiateViewController(withIdentifier: type.reuseIndentifier) as? T
            else {
                fatalError()
        }
        return vc
    }
}
