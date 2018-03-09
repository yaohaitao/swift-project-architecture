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
        return createPromise(url: url, method: .put, parameters: parameters)
    }

    func deleteItem(url: String, parameters: Parameters) -> Promise<ModelType> {
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
                        // 変えられるJSONデータを取得、失敗だったら、.failureを実行
                        let jsonData = dataResponse.value!
                        // JSONデータをモデルオブジェクトに変える
                        do {
                            let item = try ModelType(fromJSON: jsonData)
                            resolve.fulfill(item)
                            return
                        } catch SAError.callApiError(reason:
                            // 変換失敗
                            SAError.CallApiErrorReason.invalidJsonToObject(json: jsonData)) {
                                resolve.reject(SAError.callApiError(reason: .invalidJsonToObject(json: jsonData)))
                                return
                        } catch {
                            // 他のエラー
                            resolve.reject(SAError.callApiError(reason:
                                .otherError(message: error.localizedDescription)))
                            return
                        }
                    case .failure(let error):
                        if case AFError.responseValidationFailed(reason: _) = error {
                            // サーバー返信に関するエラー
                            resolve.reject(SAError.callApiError(reason:
                                .requestFailed(message: error.localizedDescription)))
                            return
                        } else if case AFError.responseSerializationFailed(reason: _) = error {
                            // サーバーからデータをJSONに変換できない
                            let data = dataResponse.data
                            let utf8Text = String(data: data!, encoding: .utf8)
                            resolve.reject(SAError.callApiError(reason:
                                .invalidDataToJson(data: utf8Text!)))
                            return
                        } else {
                            // 接続エラー
                            resolve.reject(SAError.callApiError(reason:
                                .internetConnectFailed(message: error.localizedDescription)))
                            return
                        }
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
                            // サーバー返信に関するエラー
                            resolve.reject(SAError.callApiError(reason:
                                .requestFailed(message: error.localizedDescription)))
                            return
                        } else if case AFError.responseSerializationFailed(reason: _) = error {
                            // サーバーからデータをJSONに変換できない
                            let data = dataResponse.data
                            let utf8Text = String(data: data!, encoding: .utf8)
                            resolve.reject(SAError.callApiError(reason:
                                .invalidDataToJson(data: utf8Text!)))
                            return
                        } else {
                            // 接続エラー
                            resolve.reject(SAError.callApiError(reason:
                                .internetConnectFailed(message: error.localizedDescription)))
                            return
                        }
                    }
            }
        }
    }
}
