//
//  ActivityIndicator.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/1.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public class ActivityIndicator {

    private let _lock = NSRecursiveLock()
    private let _variable = Variable(false)
    private let _loading: SharedSequence<SharingStrategy, Bool>

    public init() {
        _loading = _variable.asDriver()
            .distinctUntilChanged()
    }

    func trackActivityOfObservable<O: ObservableConvertibleType>(_ source: O) -> Observable<O.E> {
        return source.asObservable()
            .do(onNext: { _ in
                self.sendStopLoading()
            }, onError: { _ in
                self.sendStopLoading()
            }, onCompleted: {
                self.sendStopLoading()
            }, onSubscribe: subscribed)
    }

    private func subscribed() {
        _lock.lock()
        _variable.value = true
        _lock.unlock()
    }

    private func sendStopLoading() {
        _lock.lock()
        _variable.value = false
        _lock.unlock()
    }

}

extension ActivityIndicator: SharedSequenceConvertibleType {
    //  swiftlint:disable type_name
    public typealias E = Bool
    public typealias SharingStrategy = DriverSharingStrategy

    public func asSharedSequence() -> SharedSequence<DriverSharingStrategy, Bool> {
        return _loading
    }
}
