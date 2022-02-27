//
//  FrindesViewPresenter.swift
//  ChatApp
//
//  Created by ModyMayaAser on 26/02/2022.
//

import Foundation

class FrindesViewPresenter : FrindesViewPresenterProtocol {
    
    private weak var view: FrindesViewProtocol?
    private let AuthenticationService : AuthenticationServicesProtocol? = AuthenticationServices()
    private var frindesArrary: [frindeItem] = []
    
    init(view: FrindesViewProtocol) {
       self.view = view
    }
    
    func getFrindesCount() -> Int {
        frindesArrary.count
    }
    
    func getFrindeItem(index : Int) -> frindeItem {
        return frindesArrary[index]
    }
    
    func getMyFrindes() {
        print("request my frindes link")
    }
    
    func getProfileData() {
        let defaults = UserDefaults.standard
        if let user = defaults.object(forKey: "user") as? Data {
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(UserModel.self, from: user) {
                self.view?.updateDate(userImage: user.user?.img ?? "")
            }else {
                self.view?.errorInAction(errorMessage: "error in user data")
            }
        }else {
            self.view?.errorInAction(errorMessage: "user not found")
        }
    }
    
}


protocol FrindesViewPresenterProtocol : AnyObject {
    func getFrindesCount() -> Int
    func getFrindeItem(index : Int) -> frindeItem
    func getMyFrindes()
    func getProfileData()
}

protocol FrindesViewProtocol: AnyObject {
    func notifiyDataChange()
    func updateDate(userImage : String)
    func errorInAction(errorMessage : String)
}
