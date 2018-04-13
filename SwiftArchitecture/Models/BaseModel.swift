//
// Created by 姚海涛 on 2018/4/12.
// Copyright (c) 2018 yaohaitao. All rights reserved.
//

import Foundation

/// 基础实体模型
protocol BaseModel: Modelable {

    /// 方便将模型转成字典格式
    var parameters: [String: Any] {
        get
    }
}
