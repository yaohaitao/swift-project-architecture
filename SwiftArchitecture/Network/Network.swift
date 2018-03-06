//
//  Network.swift
//  SwiftArchitecture
//
//  Created by 姚海涛 on 2018/3/2.
//  Copyright © 2018年 yaohaitao. All rights reserved.
//

import Alamofire
import Alamofire_SwiftyJSON
import PromiseKit

class Network<ModelType: Modelable> {

    func getItems(url: String) -> Promise<[ModelType]> {
        return createPromiseResultWithItems(url: url, method: .get)
    }

    func getItem(url: String, parameters: Parameters) -> Promise<ModelType> {
        return createPromise(url: url, method: .get, parameters: parameters)
    }

    func postItem(url: String, parameters: Parameters) -> Promise<ModelType> {
        return createPromise(url: url, method: .post, parameters: parameters)
    }

    func updateItem(url: String, parameters: Parameters) -> Promise<ModelType> {
        // FIXME: Decide the method
        return createPromise(url: url, method: .put, parameters: parameters)
    }

    func deleteItem(url: String, parameters: Parameters) -> Promise<ModelType> {
        // FIXME: Decide the method
        return createPromise(url: url, method: .delete, parameters: parameters)
    }

    private func createPromise(url: String,
                               method: HTTPMethod,
                               parameters: Parameters) -> Promise<ModelType> {
        return Promise<ModelType> { resolve in
            Alamofire.request(url, method: method, parameters: parameters)
                .validate()
                .responseSwiftyJSON { dataResponse in
                    switch dataResponse.result {
                    case .success:

                        let jsonData = dataResponse.value!

                        do {
                            let item = try ModelType(fromJSON: jsonData)
                            resolve.fulfill(item)
                            return
                        } catch SAError.callApiError(reason:
                            SAError.CallApiErrorReason.invalidJsonToObject(json: jsonData)) {
                                resolve.reject(SAError.callApiError(reason: .invalidJsonToObject(json: jsonData)))
                                return
                        } catch {
                            resolve.reject(SAError.callApiError(reason:
                                .otherError(message: error.localizedDescription)))
                            return
                        }

                    case .failure(let error):
                        guard case AFError.responseValidationFailed(reason: _) = error else {
                            guard
                                let data = dataResponse.data,
                                let utf8Text = String(data: data, encoding: .utf8) else {
                                    resolve.reject(SAError.callApiError(reason:
                                        .otherError(message: error.localizedDescription)))
                                    return
                            }
                            resolve.reject(SAError.callApiError(reason: .invalidDataToJson(data: utf8Text)))
                            return
                        }
                        resolve.reject(SAError.callApiError(reason:
                            .requestFailed(message: error.localizedDescription)))
                        return
                    }
            }
        }
    }

    private func createPromiseResultWithItems(url: String,
                                              method: HTTPMethod,
                                              parameters: Parameters? = nil) -> Promise<[ModelType]> {
        return Promise<[ModelType]> { resolve in
            Alamofire.request(url, method: method, parameters: parameters)
                .validate()
                .responseSwiftyJSON { dataResponse in

                    switch dataResponse.result {
                    case .success:

                        guard let jsonData = dataResponse.value, let jsonArray = jsonData.array else {
                            resolve.reject(SAError.callApiError(reason: .invalidJsonToArray(json: dataResponse.value!)))
                            return
                        }

                        var items: [ModelType] = []
                        for json in jsonArray {
                            do {
                                let item = try ModelType(fromJSON: json)
                                items.append(item)
                            } catch SAError.callApiError(reason:
                                SAError.CallApiErrorReason.invalidJsonToObject(json: json)) {
                                    resolve.reject(SAError.callApiError(reason: .invalidJsonToObject(json: json)))
                                    return
                            } catch {
                                resolve.reject(SAError.callApiError(reason:
                                    .otherError(message: error.localizedDescription)))
                                return
                            }
                        }
                        resolve.fulfill(items)
                        return
                    case .failure(let error):
                        guard case AFError.responseValidationFailed(reason: _) = error else {
                            guard
                                let data = dataResponse.data,
                                let utf8Text = String(data: data, encoding: .utf8) else {
                                    resolve.reject(SAError.callApiError(reason:
                                        .otherError(message: error.localizedDescription)))
                                    return
                            }
                            resolve.reject(SAError.callApiError(reason: .invalidDataToJson(data: utf8Text)))
                            return
                        }
                        resolve.reject(SAError.callApiError(reason:
                            .requestFailed(message: error.localizedDescription)))
                        return
                    }
            }
        }
    }
}
