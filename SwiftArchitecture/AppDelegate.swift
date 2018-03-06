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

        let window = UIWindow(frame: UIScreen.main.bounds)

        let storyBoard = UIStoryboard(name: Config.mainStoryboard, bundle: nil)

        let postNavController = UINavigationController()
        postNavController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.bookmarks, tag: 0)
        let postNavigator = PostNavigator(service: PostService(), navigationController: postNavController, storyBoard: storyBoard)

        postNavigator.toPostView()

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            postNavController
        ]
        window.rootViewController = tabBarController

        self.window = window
        return true
    }
}
