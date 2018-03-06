//
//  CustomError.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/6.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum SAError: Error {

    case callApiError(reason: CallApiErrorReason)

    public enum CallApiErrorReason {
        case invalidDataToJson(data: String)
        case invalidJsonToObject(json: JSON)
        case invalidJsonToArray(json: JSON)
        case requestFailed(message: String)
        case otherError(message: String)
    }
}

extension SAError.CallApiErrorReason {
    var localizedDescription: String {
        switch self {
        case .invalidDataToJson(let data):
            return "JSON could not be serialized with data: \(data)"
        case .invalidJsonToObject(let json):
            return "Object could not be initialized with JSON data: \(json)"
        case .invalidJsonToArray(let json):
            return "Array could not be transformed with JSON data: \(json)"
        case .requestFailed(let message):
            return "Request failed: \(message)"
        case .otherError(let message):
            return message
        }
    }
}

extension SAError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .callApiError(let reason):
            return reason.localizedDescription
        }
    }
}
