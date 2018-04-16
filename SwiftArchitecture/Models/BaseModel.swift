//
// Created by 姚海涛 on 2018/4/12.
// Copyright (c) 2018 yaohaitao. All rights reserved.
//

import Foundation

/// 基本のモデル
protocol BaseModel: Modelable {

    /// モデルを辞書型に便利に変換する
    var parameters: [String: Any] {
        get
    }
}
