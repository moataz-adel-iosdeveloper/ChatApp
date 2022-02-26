//
//  ProfilePresenter.swift
//  ChatApp
//
//  Created by ModyMayaAser on 26/02/2022.
//

import Foundation
import UIKit

class ProfilePresenter : ProfilePresenterProtocol {
    
    private weak var view: ProfileProtocol?
    private let AuthenticationService : AuthenticationServicesProtocol? = AuthenticationServices()
    
    init(view: ProfileProtocol) {
       self.view = view
    }
    func getProfileData() {
        let defaults = UserDefaults.standard
        if let user = defaults.object(forKey: "user") as? Data {
            let decoder = JSONDecoder()
            if let userModel = try? decoder.decode(UserModel.self, from: user) {
                self.view?.updateDate(user: userModel)
            }else {
                self.view?.errorInAction(errorMessage: "error in user data")
            }
        }else {
            self.view?.errorInAction(errorMessage: "user not found")
        }
    }
    func updateProfile(phoneNumber: String?, img: UIImage?, userName: String?) {
        let stringError = validationUpdateProfile(phoneNumber: phoneNumber, img: img, userName: userName)
        guard stringError == "" else {
            self.view?.errorInAction(errorMessage: stringError)
            return
        }
        updateProfile(phoneNumber: phoneNumber, img: img, userName: userName)
    }
    
    private func updateProfileWithService(phoneNumber: String?, img: UIImage?, userName: String?) {
        AuthenticationService?.updateInfo(fullname: userName, phone: phoneNumber, img: img, completion: {
            [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(_):
                self.view?.errorInAction(errorMessage: "update information succeeded")
            case .failure(let error):
                self.view?.errorInAction(errorMessage: error.userInfo[NSLocalizedDescriptionKey] as? String ?? "")
            }
        })
    }
    
    private func validationUpdateProfile(phoneNumber: String?, img: UIImage?, userName: String?) -> String {
        var errorMessage = ""
        if phoneNumber == "" &&  userName == "" && img == nil{
            errorMessage = "nothing to update"
        }
        return errorMessage
    }
    
    
}


protocol ProfileProtocol: AnyObject {
    func errorInAction(errorMessage : String)
    func updateDate(user : UserModel)
}

protocol ProfilePresenterProtocol: AnyObject {
    func updateProfile(phoneNumber: String?, img: UIImage?, userName: String?)
    func getProfileData()
}

