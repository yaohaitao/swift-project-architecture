//
//  Modelable.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/5.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import SwiftyJSON

public protocol Modelable {

    init(fromJSON json: JSON) throws
}
