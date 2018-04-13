//
// Created by 姚海涛 on 2018/4/12.
// Copyright (c) 2018 yaohaitao. All rights reserved.
//

import LocalAuthentication

class BiometricsAuthentication {

    private let authenticationContext = LAContext()
    private var error: NSError?
    var canEvaluatePolicy: Bool {
        return authenticationContext.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &error)
    }

    func start(withReason reason: String,
               successHandler: @escaping () -> Void,
               errorHandler: ((_ error: Error) -> Void)? = nil) {

        if canEvaluatePolicy {
            authenticationContext.localizedFallbackTitle = ""
            authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                                 localizedReason: reason) { success, error in
                if success {
                    successHandler()
                } else {
                    NSLog(error!.localizedDescription)
//                    errorHandler(error!)
                }
            }
        } else {
            NSLog(error!.localizedDescription)
            errorHandler?(error!)
        }

    }
}
