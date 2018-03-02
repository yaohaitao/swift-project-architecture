//
//  ViewModelType.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/1.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
