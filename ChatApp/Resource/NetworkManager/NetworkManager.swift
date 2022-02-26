//
//  NetworkManager.swift
//  ChatApp
//
//  Created by ModyMayaAser on 25/02/2022.
//

import Foundation
import Alamofire

class NetworkManager<T: RequestType> {
    
    func fetchData<M: Decodable>(target: T, responseClass: M.Type, completion:@escaping (Result<M?, NSError>) -> Void) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        AF.request(target.path, method: method, parameters: params.0, encoding: params.1, headers: headers).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else {
                // ADD Custom Error
                let error = NSError(domain: target.path, code: 0, userInfo: [NSLocalizedDescriptionKey: NetworkErrorMessage.genericError])
                completion(.failure(error))
                return
            }
            if statusCode == 200 { // 200 reflect success response
                // Successful request
                guard let jsonResponse = try? response.result.get() else {
                    // ADD Custom Error
                    let error = NSError(domain: target.path, code: 0, userInfo: [NSLocalizedDescriptionKey: NetworkErrorMessage.parsingError])
                    completion(.failure(error))
                    return
                }
                guard let theJSONData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {
                    // ADD Custom Error
                    let error = NSError(domain: target.path, code: 0, userInfo: [NSLocalizedDescriptionKey: NetworkErrorMessage.parsingError])
                    completion(.failure(error))
                    return
                }
                guard let responseObj = try? JSONDecoder().decode(M.self, from: theJSONData) else {
                    // ADD Custom Error
                    let error = NSError(domain: target.path, code: 0, userInfo: [NSLocalizedDescriptionKey: NetworkErrorMessage.parsingError])
                    completion(.failure(error))
                    return
                }
                completion(.success(responseObj))
            } else {
                var error = NSError()
                if statusCode == 401 {
                    error = NSError(domain: target.path,
                                          code: statusCode,
                                    userInfo: [NSLocalizedDescriptionKey: NetworkErrorMessage.unauthorizedError])
                }else {
                    error = NSError(domain: target.path,
                                          code: statusCode,
                                      userInfo: [NSLocalizedDescriptionKey: NetworkErrorMessage.serverError])
                }
                completion(.failure(error))
            }
        }
    }
    
    func uploadData<M: Decodable>(target: T, responseClass: M.Type, completion:@escaping (Result<M?, NSError>) -> Void) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        let images = target.imgs
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in params.0 {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            for (key,value) in images.enumerated() {
                multipartFormData.append(value.value.pngData()!, withName: value.key, fileName: "\(key)\(value.key).png", mimeType: "image/png")
            }
        }, to: target.path , usingThreshold: UInt64.init(), method: method, headers: headers)
            .validate(statusCode: 200..<500)
            .responseJSON { (response) in
                guard let statusCode = response.response?.statusCode else {
                    // ADD Custom Error
                    let error = NSError(domain: target.path, code: 0, userInfo: [NSLocalizedDescriptionKey: NetworkErrorMessage.genericError])
                    completion(.failure(error))
                    return
                }
                if statusCode == 201 { // 200 reflect success response
                    // Successful request
                    guard let jsonResponse = try? response.result.get() else {
                        // ADD Custom Error
                        let error = NSError(domain: target.path, code: 0, userInfo: [NSLocalizedDescriptionKey: NetworkErrorMessage.parsingError])
                        completion(.failure(error))
                        return
                    }
                    guard let theJSONData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {
                        // ADD Custom Error
                        let error = NSError(domain: target.path, code: 0, userInfo: [NSLocalizedDescriptionKey: NetworkErrorMessage.parsingError])
                        completion(.failure(error))
                        return
                    }
                    guard let responseObj = try? JSONDecoder().decode(M.self, from: theJSONData) else {
                        // ADD Custom Error
                        let error = NSError(domain: target.path, code: 0, userInfo: [NSLocalizedDescriptionKey: NetworkErrorMessage.parsingError])
                        completion(.failure(error))
                        return
                    }
                    completion(.success(responseObj))
                } else {
                    var error = NSError()
                    switch statusCode {
                    case 401:
                        error = NSError(domain: target.path,
                                              code: statusCode,
                                        userInfo: [NSLocalizedDescriptionKey: NetworkErrorMessage.unauthorizedError])
                    case 422:
                        error = NSError(domain: target.path,
                                              code: statusCode,
                                          userInfo: [NSLocalizedDescriptionKey: NetworkErrorMessage.serverError])
                    default:
                        error = NSError(domain: target.path,
                                              code: statusCode,
                                        userInfo: [NSLocalizedDescriptionKey: NetworkErrorMessage.serverProsseingError])
                    }
                    completion(.failure(error))
                }
        }
    }
    private func buildParams(task: Task) -> ([String:Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
}
