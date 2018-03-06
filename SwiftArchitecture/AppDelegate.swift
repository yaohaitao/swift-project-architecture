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

        // Storyboardの名前で、Storyboardを取得
        let storyBoard = UIStoryboard(name: Config.mainStoryboard, bundle: nil)

        // NavigationControllerの作成
        let postNavigationController = UINavigationController()
        // NavigationControllerのタブバーの設定
        postNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.bookmarks, tag: 0)

        // Postの案内者を作成
        let postNavigator = PostNavigator(service: PostService(), navigationController: postNavigationController, storyBoard: storyBoard)
        // PostView画面を誘導
        postNavigator.toPostView()

        // タブバーの作成
        let tabBarController = UITabBarController()
        // NavigationControllerをタブバーに追加
        tabBarController.viewControllers = [
            postNavigationController
        ]

        // タブターをウインドーのルートビューに設定する
        window.rootViewController = tabBarController

        self.window = window
        return true
    }
}
