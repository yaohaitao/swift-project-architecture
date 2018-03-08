//
//  Post.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Post: Modelable {

    // MARK: - フィールドの定義
    var content: String
    var title: String
    var postId: Int

    // MARK: - 初期化方法の定義
    init(postId: Int,
         content: String,
         title: String) {
        self.postId = postId
        self.content = content
        self.title = title
    }

// MARK: - JSONデータをこのオブジェクトに変える
    init(fromJSON json: JSON) throws {
        guard let postId = json["postId"].int,
            let title = json["title"].string,
            let content = json["content"].string else {
                // 変えられないと、エラー
                throw SAError.callApiError(reason: SAError.CallApiErrorReason.invalidJsonToObject(json: json))
        }
        self.postId = postId
        self.title = title
        self.content = content
    }
}

extension Post: Equatable {

    public static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.title == rhs.title &&
            lhs.content == rhs.content &&
            lhs.postId == rhs.postId
    }

}
