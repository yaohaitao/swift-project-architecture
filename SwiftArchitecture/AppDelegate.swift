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

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let postsVC = storyboard.instantiateViewController(ofType: PostViewController.self)
        postsVC.viewModel = PostViewModel(postService: PostService())
//        postsVC.viewModel = PostsViewModel(postsService: PostsService())

        let navController = UINavigationController(rootViewController: postsVC)

        window.rootViewController = navController
        self.window = window
        return true
    }
}
