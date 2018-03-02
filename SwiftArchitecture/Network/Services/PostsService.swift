//
//  PostsService.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/1.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import Foundation
import RxSwift
//import RxCocoa

class PostsService {

    func listPosts() ->  Observable<[Post]> {

        let posts: Variable<[Post]> = Variable([])
        for i in 1...5 {
            posts.value.append(Post(body: "No.\(i) said that ...", title: "Title \(i)"))
        }
        return posts.asObservable()
    }
}
