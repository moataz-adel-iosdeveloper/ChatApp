//
//  AuthUrls.swift
//  ChatApp
//
//  Created by ModyMayaAser on 25/02/2022.
//

import Foundation

struct AuthUrls {
    
    //MARK: signUp  post {fullname , phone , img , password}
    static var signUp = domainUrl.mainDomain + "api/v1/signup"
    
    //MARK: signIn  post {phone , password}
    static var signIn = domainUrl.mainDomain + "api/v1/signin"
    
    //MARK: updateInfo  put {fullname , phone , img , header : (Authorization : Bearer token)}
    static var updateInfo = domainUrl.mainDomain +  "api/v1/user/1/updateInfo"
    
    //MARK: updatePassword  put {currentPassword , newPassword , header : (Authorization : Bearer token)}
    static var updatePassword = domainUrl.mainDomain +  "api/v1/user/updatePassword"
    
}
