//
//  authenticationProtocol.swift
//  ChatApp
//
//  Created by ModyMayaAser on 26/02/2022.
//

import Foundation
import UIKit

protocol AuthenticationServicesProtocol {
    func signIn(phone: String, password: String , completion: @escaping (Result<UserModel?, NSError>) -> Void)
    func signUp(fullname: String, phone: String, password: String, img : UIImage , completion: @escaping (Result<UserModel?, NSError>) -> Void)
    func updateInfo(fullname: String?, phone: String?,img : UIImage? , completion: @escaping (Result<UserModel?, NSError>) -> Void)
//    func updatePassword(currentPassword: String, newPassword: String , completion: @escaping (Result<UserModel, NSError>) -> Void)
}

class AuthenticationServices : NetworkManager<AuthenticationNetwork>, AuthenticationServicesProtocol {
    func signIn(phone: String, password: String, completion: @escaping (Result<UserModel?, NSError>) -> Void) {
        self.fetchData(target: AuthenticationNetwork.signIn(phone: phone, password: password), responseClass: UserModel.self) { (result) in
            switch result {
            case .success(let user):
                user?.saveToUserDefaults()
            case .failure(let error):
                print(error.description)
            }
            completion(result)
        }
    }
    
    func signUp(fullname: String, phone: String, password: String, img: UIImage, completion: @escaping (Result<UserModel?, NSError>) -> Void) {
        self.uploadData(target: AuthenticationNetwork.signUp(fullname: fullname, phone: phone, password: password, img: img), responseClass: UserModel.self) { (result) in
            completion(result)
        }
    }
    
    func updateInfo(fullname: String?, phone: String?, img: UIImage?, completion: @escaping (Result<UserModel?, NSError>) -> Void) {
        self.uploadData(target: AuthenticationNetwork.updateInfo(fullname: fullname, phone: phone, img: img), responseClass: UserModel.self) { (result) in
            completion(result)
        }
    }
    
//    func updatePassword(currentPassword: String, newPassword: String, completion: @escaping (Result<UserModel, NSError>) -> Void) {
//        
//    }
    
    
}
