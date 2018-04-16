//
//  LoginViewController.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/4/12.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate: class {
    func isEnableTouchIdLoginButton(enable: Bool)
}

class LoginViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var touchIdLoginButton: UIButton!

    // MARK: - 変数の定義
    var presenter: LoginPresenter!

    // MARK: - Viewのライフサイクル
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.presenter.configureLoginView()
    }

    // MARK: - IBAction
    @IBAction func didTappedLoginButton(_ sender: UIButton) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        let user = User(username: username, password: password)
        self.presenter.userLogin(user: user)
    }

    @IBAction func didTappedLoginWithTouchIdButton(_ sender: UIButton) {
        self.presenter.userLoginWithTouchId()
    }

}

extension LoginViewController: LoginViewControllerDelegate {
    func isEnableTouchIdLoginButton(enable: Bool) {
        touchIdLoginButton.isHidden = !enable
    }
}
