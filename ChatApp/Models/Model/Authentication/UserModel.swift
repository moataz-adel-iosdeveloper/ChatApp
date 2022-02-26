//
//  UserModel.swift
//  ChatApp
//
//  Created by ModyMayaAser on 26/02/2022.
//

import Foundation

// MARK: - UserModel
struct UserModel: Codable {
    let user: User?
    let token: String?
}

// MARK: - User
struct User: Codable {
    let friends: [Int]?
    let fullname, phone: String?
    let img: String?
    let id: Int?
}

extension UserModel {
    func saveToUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "user")
        }
    }
}


