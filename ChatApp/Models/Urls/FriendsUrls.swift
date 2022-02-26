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
    
    //MARK: getFriends  get {header : (Authorization : Bearer token)}
    static var getFriends = domainUrl.mainDomain + "api/v1/friends/1/friends"
    
}
