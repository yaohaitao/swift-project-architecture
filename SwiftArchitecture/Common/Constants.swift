//
//  Constants.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/2/27.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 环境信息
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
 // */

// MARK: - 配置信息

enum Config {
    static let baseURL: String = {
        switch Enviroment.currentConfig {
        case .development:
            return "https://development/"
        case .continuousIntegration:
            return "https://continuousintegration/"
        case .testing:
            return "https://testing/"
        case .staging:
            return "https://staging/"
        case .production:
            return "https://production/"
        }
    }()
}

// MARK: - 颜色信息

enum Color {
    static let primaryColor = UIColor.black
}
