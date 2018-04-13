//
//  Constants.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/2/27.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import UIKit

// MARK: - 环境设置
private enum Enviroment {

    case development
    case continuousIntegration
    case testing
    case staging
    case production

    static let currentConfig: Enviroment = {
        #if DEVELOPMENT
            return .development
        #elseif CONTINUOUS_INTEGRATION
            return .continuousIntegration
        #elseif TESTING
            return .testing
        #elseif STAGING
            return .staging
        #elseif PRODUCTION
            return .production
        #else
            return .development
        #endif
    }()
}

// MARK: - 常用字符串
enum Config {
    static let mainStoryboard = "Main"
}

// MARK: - URL定义
enum URLs {

    static let baseURL: String = {
        switch Enviroment.currentConfig {
        case .development:
            return "http://localhost/EditriumAPI"
        case .continuousIntegration:
            return "https://continuousintegration"
        case .testing:
            return "https://testing"
        case .staging:
            return "https://staging"
        case .production:
            return "https://production"
        }
    }()

    static let postURL = URLs.baseURL + "/" + "post.php"
    static let loginURL = URLs.baseURL + "/" + "login.php"
}

// MARK: - 颜色定义
enum Color {
    static let primaryColor = UIColor.black
}

// MARK: - 字段定义
enum Fields {

    enum User {
        static let username = "username"
        static let password = "password"
    }

    enum Post {
        static let postId = "postId"
        static let title = "tilte"
        static let content = "content"
    }

}

// MARK: - Defaults 文件中键的定义
enum DefaultsKeys {
    // Key<值的类型>("键")
    static let enableTouchIdLogin = Key<Bool>("enableTouchIdLogin")
}

// MARK: - Defaults 文件中常用的值
enum DefaultsValues {

    static var enableTouchIdLogin: Bool {
        get {
            return Defaults.shared.get(for: DefaultsKeys.enableTouchIdLogin) ?? false
        }

        set {
            // 当这个值发生变化的时候，发送通知
            let notificationName = Notification.Name(rawValue: "TouchIdSetting")
            NotificationCenter.default.post(name: notificationName, object: newValue)
            // 将新值写入 Defaults 文件
            Defaults.shared.set(newValue, for: DefaultsKeys.enableTouchIdLogin)
        }
    }
}
