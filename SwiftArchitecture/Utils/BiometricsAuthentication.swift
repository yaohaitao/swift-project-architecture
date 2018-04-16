//
// Created by 姚海涛 on 2018/4/12.
// Copyright (c) 2018 yaohaitao. All rights reserved.
//

import LocalAuthentication

class BiometricsAuthentication {

    private let authenticationContext = LAContext()
    private var error: NSError?
    /// デバイスは生体認証できるかどうか判定したフラグ
    var isSupported: Bool {
        return authenticationContext.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &error)
    }

    /// 生体認証を始める
    ///
    /// - Parameters:
    ///   - reason: ユーザーに表示するメッセージ
    ///   - successHandler: 認証を成功した実行すべきコード
    ///   - errorHandler: 認証を失敗した実行すべきコード
    func start(withReason reason: String,
               successHandler: @escaping () -> Void,
               errorHandler: ((_ error: Error) -> Void)? = nil) {

        if self.isSupported {
            authenticationContext.localizedFallbackTitle = ""
            authenticationContext.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: reason) { success, error in
                    // メインスレッドに認証した操作を実行する
                    OperationQueue.main.addOperation {
                        if success {
                            successHandler()
                        } else {
                            NSLog(error!.localizedDescription)
                            errorHandler?(error!)
                        }
                    }
            }
        } else {
            NSLog(error!.localizedDescription)
            errorHandler?(error!)
        }

    }
}
