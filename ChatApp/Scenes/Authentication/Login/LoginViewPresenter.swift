//
//  LoginViewPresenter.swift
//  ChatApp
//
//  Created by ModyMayaAser on 25/02/2022.
//

import Foundation

class LoginViewPresenter: LoginPresenterProtocol {
    
    private weak var view: LoginViewProtocol?
    private let AuthenticationService : AuthenticationServicesProtocol? = AuthenticationServices()
    
    init(view: LoginViewProtocol) {
       self.view = view
    }
    
    func login(phoneNumber: String, password: String) {
        let stringError = validationLogain(phoneNumber: phoneNumber, password: password)
        guard stringError == "" else {
            self.view?.errorInAction(errorMessage: stringError)
            return
        }
        loginWithService(phoneNumber: phoneNumber, password: password)
    }
    
    private func loginWithService(phoneNumber: String, password: String) {
        AuthenticationService?.signIn(phone: phoneNumber, password: password, completion: { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(_):
                self.view?.loginSuccess()
            case .failure(let error):
                self.view?.errorInAction(errorMessage: error.description)
            }
        })
    }
    
    private func validationLogain(phoneNumber: String?, password: String?) -> String {
        var errorMessage = ""
        if phoneNumber == "" || phoneNumber == nil {
            errorMessage = errorMessage + "  " + "Phone Number is empty"
        }
        if password == "" || password == nil {
            errorMessage = errorMessage + "  " + "Password is empty"
        }
        return errorMessage
    }
}

protocol LoginViewProtocol: AnyObject {
    func errorInAction(errorMessage : String)
    func loginSuccess()
}

protocol LoginPresenterProtocol: AnyObject {
    func login(phoneNumber: String, password: String)
}
