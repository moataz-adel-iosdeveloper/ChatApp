//
//  Friends.swift
//  ChatApp
//
//  Created by ModyMayaAser on 25/02/2022.
//

import Foundation

struct FriendsUrls {
    
    //MARK: removeFriend  put {header : (Authorization : Bearer token)}
    static var removeFriend = domainUrl.mainDomain + "api/v1/friends/2/unFriend"
    
    //MARK: getMyFriends  get {header : (Authorization : Bearer token)}
    static var getMyFriends = domainUrl.mainDomain + "api/v1/friends/1/friends"
    
    //MARK: getAllFriends get {}
    static func getAllFriends(pageNumber : Int , limitNumber : Int) -> String {
        return domainUrl.mainDomain + "api/v1/getAll?page=\(pageNumber)&limit=\(limitNumber)"
    }
    
    
}
