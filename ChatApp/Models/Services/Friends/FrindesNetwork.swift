//
//  FrindesNetwork.swift
//  ChatApp
//
//  Created by ModyMayaAser on 26/02/2022.
//

import Foundation
import Alamofire
import UIKit

enum FrindesNetwork {
    //MARK: getMyFriends  get {header : (Authorization : Bearer token)}
    case getMyFriends
    //MARK: getAllFriends get {}
    case getAllFriends(page : Int , limit : Int)
}

extension FrindesNetwork: RequestType {
    var imgs: [String : UIImage] {
        switch self {
        default:
            return [:]
        }
    }
    
    var path: String {
        switch self {
        case .getAllFriends(let page , let limit):
            return FriendsUrls.getAllFriends(pageNumber: page, limitNumber: limit)
        case .getMyFriends:
            return FriendsUrls.getMyFriends
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getAllFriends:
            return [:]
        case .getMyFriends:
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
        }
    }
}


