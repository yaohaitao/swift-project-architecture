//
// Created by 姚海涛 on 2018/4/12.
// Copyright (c) 2018 yaohaitao. All rights reserved.
//

import UIKit
import PromiseKit

class LoginPresenter {
    // MARK: - 定义变量
    private let service: LoginService
    private let navigator: LoginNavigator
    private weak var delegate: LoginViewControllerDelegate?

    // MARK: - 初始化
    required init(service: LoginService, navigator: LoginNavigator, delegate: LoginViewControllerDelegate) {
        self.service = service
        self.navigator = navigator
        self.delegate = delegate
    }

    // MARK: - 方法
    func configureLoginView() {
        delegate?.isEnableTouchIdLoginButton(enable: DefaultsValues.enableTouchIdLogin)
    }

    func userLogin(user: User) {
        service.userLogin(user: user)
            .done {result in
                guard result.status == 1 else {
                    print("login failed")
                    return
                }

                self.navigator.toPostView()
                if BiometricsAuthentication().canEvaluatePolicy && !DefaultsValues.enableTouchIdLogin {
                    self.alertForAskTouchIdStatus()
                }
            }.catch { error in
                if case let
                    SAError.callApiError(reason: .internetConnectFailed(message: message)) = error {
                    print("do handle with network connect error" + message)
                } else {
                    print(error.localizedDescription)
                }
        }
    }

    func userLoginWithTouchId() {
        BiometricsAuthentication().start(withReason: "Use touch id to login", successHandler: {
            self.navigator.toPostView()
        }, errorHandler: nil)
    }

    // MARK: - 私有方法
    private func alertForAskTouchIdStatus() {
        let title = "Touch Id"
        let message = "You can use touch id to login next time."
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            BiometricsAuthentication().start(withReason: "For First Register", successHandler: {
                DefaultsValues.enableTouchIdLogin = true
            }, errorHandler: nil)
        }))

        alert.addAction(UIAlertAction(title: "No", style: .cancel))

        self.navigator.presentAlert(alert: alert)
    }
}
