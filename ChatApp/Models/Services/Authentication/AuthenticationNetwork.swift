//
//  AuthenticationServices.swift
//  ChatApp
//
//  Created by ModyMayaAser on 25/02/2022.
//

import Foundation
import Alamofire
import UIKit
  
enum AuthenticationNetwork {
    //MARK: signUp  post {fullname , phone , img , password}
    case signUp(fullname: String, phone: String, password: String, img : UIImage)
    //MARK: signIn  post {phone , password}
    case signIn(phone: String, password: String)
    //MARK: updateInfo  put {fullname , phone , img , header : (Authorization : Bearer token)}
    case updateInfo(fullname: String?, phone: String?,img : UIImage?)
    //MARK: updatePassword  put {currentPassword , newPassword , header : (Authorization : Bearer token)}
    case updatePassword(currentPassword: String, newPassword: String)
}

extension AuthenticationNetwork: RequestType {
    var imgs: [String : UIImage] {
        switch self {
        case .signIn:
            return [:]
        case .signUp(_, _, _, let img):
            return ["img" : img]
        case .updateInfo(_, _, let img):
            if img != nil {
                return ["img" : img!]
            }else {
                return [:]
            }
        case .updatePassword:
            return [:]
        }
    }
    
    var path: String {
        switch self {
        case .signIn:
            return AuthUrls.signIn
        case .signUp:
            return AuthUrls.signUp
        case .updateInfo:
            return AuthUrls.updateInfo
        case .updatePassword:
            return AuthUrls.updatePassword
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .signIn:
            return .post
        case .signUp:
            return .post
        case .updateInfo:
            return .put
        case .updatePassword:
            return .put
        }
    }
    
    var task: Task {
        switch self {
        case .updateInfo(let fullname, let phone,_):
            var paramters = [String:Any]()
            if fullname != nil {
                paramters["fullname"] = fullname
            }
            if phone != nil {
                paramters["phone"] = phone
            }
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)
        case .signIn(let phone, let password):
            return .requestParameters(parameters: ["phone": phone, "password": password], encoding: JSONEncoding.default)
        case .signUp(let fullname, let phone, let password,_):
            return .requestParameters(parameters: ["phone": phone, "password": password , "fullname" : fullname], encoding: JSONEncoding.default)
        case .updatePassword(let currentPassword,let newPassword):
            return .requestParameters(parameters: ["currentPassword" : currentPassword , "newPassword" : newPassword], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .signIn:
            return [:]
        case .signUp:
            return [:]
        case .updateInfo:
            let defaults = UserDefaults.standard
            if let user = defaults.object(forKey: "user") as? Data {
                let decoder = JSONDecoder()
                if let userModel : UserModel = try? decoder.decode(UserModel.self, from: user){
                    return ["Authorization" : "Bearer \(userModel.token ?? "")"]
                }else {
                    return [:]
                }
            }else {
                return [:]
            }
        case .updatePassword:
            return [:]
        }
    }
}

