//
//  Saving.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 03/06/21.
//

//import Foundation
//
//// MARK: - SavingElement
//struct Saving: Codable, Identifiable {
//    let id: Int
//    let type, publishedAt, createdAt, updatedAt: String
//    var amount: Double
//    let usersPermissionsUser: UsersPermissionsUser
//    var waste: Waste?
//    var savingTransactions: [SavingTransactionB]?
//
//    enum CodingKeys: String, CodingKey {
//        case id, type
//        case publishedAt = "published_at"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case amount
//        case usersPermissionsUser = "users_permissions_user"
//        case waste
//        case savingTransactions = "saving_transactions"
//    }
//}
//
//struct SavingTransactionB: Codable, Identifiable {
//    let id: Int
//    let amount: Double
//    let type: String
//    let saving: Int?
//    let publishedAt, createdAt, updatedAt: String
//    //let usersPermissionsUser: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id, amount, type, saving
//        case publishedAt = "published_at"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        //case usersPermissionsUser = "users_permissions_user"
//    }
//
//}
//
//// MARK: - UsersPermissionsUser
//struct UsersPermissionsUser: Codable {
//    let id: Int
//    let username, email, provider: String
//    let confirmed: Bool?
//    let blocked: String?
//    let role: Int
//    let createdAt, updatedAt: String
//    let address, gender, fullname, type: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, username, email, provider, confirmed, blocked, role, type
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case address, gender, fullname
//    }
//}


import Foundation

// MARK: - SavingElement
struct Saving: Codable, Identifiable {
    let id: Int
    let type, publishedAt, createdAt, updatedAt: String
    let amount: Double
    let usersPermissionsUser: UsersPermissionsUserB
    let waste: WasteB?
    let savingTransactions: [SavingTransactionB]
    let earning: Double

    enum CodingKeys: String, CodingKey {
        case id, type, earning
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case amount
        case usersPermissionsUser = "users_permissions_user"
        case waste
        case savingTransactions = "saving_transactions"
    }
}

// MARK: - SavingTransaction
struct SavingTransactionB: Codable {
    let id: Int
    let amount: Double
    let type: String
    let saving: Int
    let publishedAt, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, amount, type, saving
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - UsersPermissionsUser
struct UsersPermissionsUserB: Codable {
    let id: Int
    let username, email, provider: String
    let confirmed: Bool
    let blocked: String?
    let role: Int
    let createdAt, updatedAt, address, gender: String
    let fullname, type: String

    enum CodingKeys: String, CodingKey {
        case id, username, email, provider, confirmed, blocked, role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case address, gender, fullname, type
    }
}

struct WasteB: Codable {
    let id: Int
    let name, category: String
    let totalSavingAmount: Double
    let publishedAt, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name, category, totalSavingAmount
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
