//
//  AllFrindesModel.swift
//  ChatApp
//
//  Created by ModyMayaAser on 26/02/2022.
//

import Foundation

struct AllFrindesModel: Codable {
    let data: [frindeItem]?
    let pageCount: Int?
}

// MARK: - Datum
struct frindeItem: Codable {
    let friends: [Int]?
    let deleted: Bool?
    let fullname, phone: String?
    let img: String?
    let id: Int?
}

