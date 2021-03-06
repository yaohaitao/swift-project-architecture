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
        return createRequestForItems(url: url, method: .get)
    }

    func getItem(url: String, parameters: Parameters) -> Promise<ModelType> {
        return createRequest(url: url, method: .get, parameters: parameters)
    }

    func postItem(url: String, parameters: Parameters) -> Promise<ModelType> {
        return createRequest(url: url, method: .post, parameters: parameters)
    }

    func updateItem(url: String, parameters: Parameters) -> Promise<ModelType> {
        return createRequest(url: url, method: .put, parameters: parameters)
    }

    func deleteItem(url: String, parameters: Parameters) -> Promise<ModelType> {
        return createRequest(url: url, method: .delete, parameters: parameters)
    }

    private func createRequest(url: String,
                               method: HTTPMethod,
                               parameters: Parameters) -> Promise<ModelType> {

        return Promise<ModelType> { resolve in

            Alamofire.request(url, method: method, parameters: parameters)
                .validate()
                .responseSwiftyJSON { dataResponse in

                    switch dataResponse.result {
                    case .success:
                        // 获取转换好的JSON数据（转换失败会到 .failure）
                        let jsonData = dataResponse.value!
                        // 将JSON数据转换成对象
                        do {
                            let item = try ModelType(fromJSON: jsonData)
                            resolve.fulfill(item)
                            return
                            // JSON数据格式错误导致无法转换
                        } catch SAError.callApiError(reason:
                            SAError.CallApiErrorReason.invalidJsonToObject(json: jsonData)) {
                                resolve.reject(SAError.callApiError(reason: .invalidJsonToObject(json: jsonData)))
                                return
                                // 其他错误
                        } catch {
                            resolve.reject(SAError.callApiError(reason:
                                .otherError(message: error.localizedDescription)))
                            return
                        }

                    case .failure(let error):
                        if case AFError.responseValidationFailed(reason: _) = error {
                            // 服务器错误
                            resolve.reject(SAError.callApiError(reason:
                                .requestFailed(message: error.localizedDescription)))
                            return
                        } else if case AFError.responseSerializationFailed(reason: _) = error {
                            // 原始数据无法转换成 JSON
                            let data = dataResponse.data
                            let utf8Text = String(data: data!, encoding: .utf8)
                            resolve.reject(SAError.callApiError(reason:
                                .invalidDataToJson(data: utf8Text!)))
                            return
                        } else {
                            // 网络错误
                            resolve.reject(SAError.callApiError(reason:
                                .internetConnectFailed(message: error.localizedDescription)))
                            return
                        }
                    }
            }
        }
    }

    private func createRequestForItems(url: String,
                                       method: HTTPMethod,
                                       parameters: Parameters? = nil) -> Promise<[ModelType]> {
        return Promise<[ModelType]> { resolve in

            Alamofire.request(url, method: method, parameters: parameters)
                .validate()
                .responseSwiftyJSON { dataResponse in

                    switch dataResponse.result {

                    case .success:

                        let jsonData = dataResponse.value!

                        guard let jsonArray = jsonData.array else {
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
                        if case AFError.responseValidationFailed(reason: _) = error {
                            // 服务器错误
                            resolve.reject(SAError.callApiError(reason:
                                .requestFailed(message: error.localizedDescription)))
                            return
                        } else if case AFError.responseSerializationFailed(reason: _) = error {
                            // 原始数据无法转换成 JSON
                            let data = dataResponse.data
                            let utf8Text = String(data: data!, encoding: .utf8)
                            resolve.reject(SAError.callApiError(reason:
                                .invalidDataToJson(data: utf8Text!)))
                            return
                        } else {
                            // 网络错误
                            resolve.reject(SAError.callApiError(reason:
                                .internetConnectFailed(message: error.localizedDescription)))
                            return
                        }
                    }
            }
        }
    }
}
