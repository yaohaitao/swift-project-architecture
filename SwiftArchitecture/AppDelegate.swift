//
//  AppDelegate.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/2/27.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//  swiftlint:disable line_length
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // Windowの作成
        let window = UIWindow(frame: UIScreen.main.bounds)

        // NavigationControllerの作成
        let rootNavigationController = UINavigationController()
        // NavigationControllerのタブバーの設定
        rootNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.bookmarks, tag: 0)

        // Loginの案内者を作成
        let loginService = ServiceProvider().makeLoginService()
        let loginNavigator = LoginNavigator(navigationController: rootNavigationController, service: loginService)
        // LoginView画面を誘導
        loginNavigator.toLoginView()

        // タブバーの作成
        let tabBarController = UITabBarController()
        // NavigationControllerをタブバーに追加
        tabBarController.viewControllers = [
            rootNavigationController
        ]

        // タブターをウインドーのルートビューに設定する
        window.rootViewController = tabBarController
        self.window = window
        return true
    }
}
