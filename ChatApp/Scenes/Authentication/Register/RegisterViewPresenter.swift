//
//  RegisterViewPresenter.swift
//  ChatApp
//
//  Created by ModyMayaAser on 25/02/2022.
//

import Foundation
import UIKit

class RegisterViewPresenter : RegisterPresenterProtocol {
    
    private weak var view: RegisterViewProtocol?
    private let AuthenticationService : AuthenticationServicesProtocol? = AuthenticationServices()
    
    init(view: RegisterViewProtocol) {
       self.view = view
    }
    
    func Register(phoneNumber: String?,password: String?, img: UIImage?, userName: String?) {
        let stringError = validationRegister(phoneNumber: phoneNumber, password: password, img: img, userName: userName)
        guard stringError == "" else {
            self.view?.errorInAction(errorMessage: stringError)
            return
        }
        RegisterWithService(phoneNumber: phoneNumber!, password: password!, img: img!, userName: userName!)
    }
    
    private func RegisterWithService(phoneNumber: String,password: String, img: UIImage, userName: String) {
        AuthenticationService?.signUp(fullname: userName, phone: phoneNumber, password: password, img: img, completion: { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(_):
                self.view?.RegisterSuccess()
            case .failure(let error):
                if error.code == 422 {
                    self.view?.errorInAction(errorMessage: "Login information is already registered,please you must log in")
                }else {
                    self.view?.errorInAction(errorMessage: error.userInfo[NSLocalizedDescriptionKey] as? String ?? "")
                }
            }
        })
    }
    
    private func validationRegister(phoneNumber: String?,password: String?, img: UIImage?, userName: String?) -> String {
        var errorMessage = ""
        if phoneNumber == "" || phoneNumber == nil {
            errorMessage = errorMessage + "  " + "Phone Number is required"
        }
        if password == "" || password == nil {
            errorMessage = errorMessage + "  " + "Password is required"
        }
        if userName == "" || userName == nil {
            errorMessage = errorMessage + "  " + "User Name is required"
        }
        if img == nil {
            errorMessage = errorMessage + "  " + "image profile is required"
        }
        return errorMessage
    }
}


protocol RegisterViewProtocol: AnyObject {
    func errorInAction(errorMessage : String)
    func RegisterSuccess()
}

protocol RegisterPresenterProtocol: AnyObject {
    func Register(phoneNumber: String?,password: String?, img: UIImage?, userName: String?)
}
