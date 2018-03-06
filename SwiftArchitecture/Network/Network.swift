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

    public func getItems(url: String) -> Promise<[ModelType]> {
        return Promise<[ModelType]> { resolve in
            Alamofire.request(url, method: .get).responseSwiftyJSON { dataResponse in
                switch dataResponse.result {
                case .success:
                    var items: [ModelType] = []
                    if let jsonArray = dataResponse.value?.array {
                        for json in jsonArray {
                            do {
                                let item = try ModelType(fromJSON: json)
                                items.append(item)
                            } catch ErrorType.invalidJSON(let message) {
//                                print(message)
                                resolve.reject(ErrorType.invalidJSON(message))
                            } catch {
//                                print("An error occurred: \(error)")
                                resolve.reject(ErrorType.otherError(error.localizedDescription))
                            }
                        }
                        resolve.fulfill(items)
                    }
                    resolve.reject(ErrorType.invalidArray(ErrorMessage.invalidArray))
                case .failure(let error):
//                    print("An error occurred: \(error)")
                    resolve.reject(ErrorType.requestFailed(error.localizedDescription))
                }
            }
        }
    }

    public func getItem(url: String, parameters: Parameters) -> Promise<ModelType> {
        return createPromise(url: url, method: .get, parameters: parameters)
    }

    public func postItem(url: String, parameters: Parameters) -> Promise<ModelType> {
        return createPromise(url: url, method: .post, parameters: parameters)
    }

    public func updateItem(url: String, parameters: Parameters) -> Promise<ModelType> {
        // FIXME: Decide the method
        return createPromise(url: url, method: .put, parameters: parameters)
    }

    public func deleteItem(url: String, parameters: Parameters) -> Promise<ModelType> {
        // FIXME: Decide the method
        return createPromise(url: url, method: .delete, parameters: parameters)
    }

    private func createPromise(url: String, method: HTTPMethod, parameters: Parameters) -> Promise<ModelType> {
        return Promise<ModelType> { resolve in
            Alamofire.request(url, method: method, parameters: parameters).responseSwiftyJSON { dataResponse in
                switch dataResponse.result {
                case .success:
                    if let json = dataResponse.value {
                        do {
                            let item = try ModelType(fromJSON: json)
                            resolve.fulfill(item)
                        } catch ErrorType.invalidJSON(let message) {
                            resolve.reject(ErrorType.invalidJSON(message))
                        } catch {
                            resolve.reject(ErrorType.otherError(error.localizedDescription))
                        }
                    }
                case .failure(let error):
                    resolve.reject(ErrorType.requestFailed(error.localizedDescription))
                }
            }
        }
    }
}
