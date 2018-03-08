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
        // 新建 Window
        let window = UIWindow(frame: UIScreen.main.bounds)

        // 新建 NavigationController
        let postNavigationController = UINavigationController()
        // 设置 NavigationController 在 tar bar 上的显示
        postNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.bookmarks, tag: 0)

        // 画面控制器
        let postService = ServiceProvider().makePostService()
        let postNavigator = PostNavigator(service: postService, navigationController: postNavigationController)
        // 跳至帖子页面
        postNavigator.toPostView()

        // 新建 Tab bar
        let tabBarController = UITabBarController()
        // 把 NavigationController 添加到 Tab bar 中
        tabBarController.viewControllers = [
            postNavigationController
        ]

        // 将 Tar bar 设置为根窗口
        window.rootViewController = tabBarController
        self.window = window
        return true
    }
}
