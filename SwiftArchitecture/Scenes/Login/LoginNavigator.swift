//
//  LoginNavigator.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/4/12.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import UIKit

class LoginNavigator {

    private let navigationController: UINavigationController
    private let service: LoginService

    init(navigationController: UINavigationController, service: LoginService) {
        self.navigationController = navigationController
        self.service = service
    }

    func toLoginView() {
        let loginViewController = LoginViewController()
        loginViewController.presenter = LoginPresenter(service: service, navigator: self, delegate: loginViewController)
        loginViewController.navigationItem.title = "Login"

        navigationController.pushViewController(loginViewController, animated: true)
    }

    func toPostView() {
        let postService = ServiceProvider().makePostService()
        let postNavigator = PostNavigator(service: postService, navigationController: navigationController)
        postNavigator.toPostView()
    }

    func presentAlert(alert: UIAlertController) {
        navigationController.present(alert, animated: true, completion: nil)
    }
}
