//
//  FrindesServices.swift
//  ChatApp
//
//  Created by ModyMayaAser on 26/02/2022.
//

import Foundation
import UIKit

protocol FrindesServicesProtocol {
    func getMyFriends(completion: @escaping (Result<AllFrindesModel?, NSError>) -> Void)
    func getAllFriends(page: Int, limit: Int ,completion: @escaping (Result<AllFrindesModel?, NSError>) -> Void)
}

class FrindesServices : NetworkManager<FrindesNetwork>, FrindesServicesProtocol {
    func getMyFriends(completion: @escaping (Result<AllFrindesModel?, NSError>) -> Void) {
        
    }
    
    func getAllFriends(page: Int, limit: Int , completion: @escaping (Result<AllFrindesModel?, NSError>) -> Void) {
        self.fetchData(target: FrindesNetwork.getAllFriends(page: page, limit: limit), responseClass: AllFrindesModel.self) { (result) in
            completion(result)
        }
    }
    
    
    
}
