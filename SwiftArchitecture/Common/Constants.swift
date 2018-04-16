//
//  Constants.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/2/27.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import UIKit

// MARK: - 環境
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

// MARK: - 常用
enum Config {
    static let mainStoryboard = "Main"
}

// MARK: - URLの定義
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

// MARK: - カラーの定義
enum Color {
    static let primaryColor = UIColor.black
}

// MARK: - フィールド名の定義
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

// MARK: - ユーザーデフォルトに、キーの名の定義
enum DefaultsKeys {
    // Key<バリューの型>("キーの名")
    static let enableTouchIdLogin = Key<Bool>("enableTouchIdLogin")
}

// MARK: - ユーザーデフォルトに保存した常用のバリュー
enum DefaultsValues {

    static var enableTouchIdLogin: Bool {
        get {
            return Defaults.shared.get(for: DefaultsKeys.enableTouchIdLogin) ?? false
        }

        set {
            // この値が変更されたときに通知を送信する
            let notificationName = Notification.Name(rawValue: "TouchIdSetting")
            NotificationCenter.default.post(name: notificationName, object: newValue)
            // ユーザーデフォルトに新しい値を書き込む
            Defaults.shared.set(newValue, for: DefaultsKeys.enableTouchIdLogin)
        }
    }
}
