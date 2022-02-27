//
//  AddFrindePresenter.swift
//  ChatApp
//
//  Created by ModyMayaAser on 26/02/2022.
//

import Foundation

class AddFrindePresenter : AddFrindePresenterProtocol {
    
    private weak var view: AddFrindeViewProtocol?
    private let frindesServices : FrindesServicesProtocol? = FrindesServices()
    private var frindesArrary: [frindeItem] = []
    private var pageCount : Int = 1
    private var currentPageCount : Int = 1
    private var pageLimit : Int = 20
    private var selectedFrinde : Int?
    private var isFetshData : Bool = false
    
    init(view: AddFrindeViewProtocol) {
       self.view = view
    }
    
    func getFrindesCount() -> Int {
        frindesArrary.count
    }
    
    func getFrindeItem(index : Int) -> frindeItem {
        return frindesArrary[index]
    }
    
    func isFetsh() -> Bool {
        return isFetshData
    }
    func isFrindeSelected(index: Int) -> Bool {
        if self.selectedFrinde != nil {
            if self.selectedFrinde == index {
                return true
            }else {
                return false
            }
        }else {
            return false
        }
    }
    
    func selectedFrinde(index: Int) {
        self.selectedFrinde = index
        self.view?.notifiyDataChange()
    }
    
    func getAllFrindes() {
        if currentPageCount <= pageCount {
            self.isFetshData = true
            frindesServices?.getAllFriends(page: currentPageCount, limit: pageLimit, completion: {
                [weak self] (result) in
                guard let self = self else {return}
                switch result {
                case .success(let model):
                    for value in model!.data! {
                        self.frindesArrary.append(value)
                    }
                    self.isFetshData = false
                    self.view?.notifiyDataChange()
                case .failure(let error):
                    self.isFetshData = false
                    self.view?.errorInAction(errorMessage: error.userInfo[NSLocalizedDescriptionKey] as? String ?? "")
                }
            })
        }
    }
    
}


protocol AddFrindePresenterProtocol : AnyObject {
    func getFrindesCount() -> Int
    func getFrindeItem(index : Int) -> frindeItem
    func isFrindeSelected(index : Int) -> Bool
    func selectedFrinde(index : Int)
    func getAllFrindes()
    func isFetsh() -> Bool
}

protocol AddFrindeViewProtocol: AnyObject {
    func notifiyDataChange()
    func errorInAction(errorMessage : String)
}
