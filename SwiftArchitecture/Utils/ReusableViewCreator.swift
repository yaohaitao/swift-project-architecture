//
//  ReusableViewCreator.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/1.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import UIKit

// MARK: - 协议定义

/// 协议：实现该协议需要拥有一个可以重用的标识
protocol Reusable {
    static var reuseIndentifier: String {get}
}

// MARK: - 方法扩充

// 实现 reuseIndentifier 的 get 方法
extension Reusable {
    /// 将可重用的标识符定义为实现该协议的类的类名
    static var reuseIndentifier: String {
        return String(describing: self)
    }
}

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
