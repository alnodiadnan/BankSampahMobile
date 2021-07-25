//
//  Waste.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 10/06/21.
//

//import Foundation
//
//// MARK: - WasteElement
//struct Waste: Codable , Identifiable {
//    let id: Int
//    let name, category: String
//    let totalSavingAmount: Double
//    let publishedAt, createdAt, updatedAt: String
//    let savings: [SavingWaste]
//    let sellTransactions : [SellTransactionB]
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, category, totalSavingAmount
//        case publishedAt = "published_at"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case savings
//        case sellTransactions = "sell_transactions"
//    }
//}
//
//// MARK: - Saving
//struct SavingWaste: Codable {
//    let id: Int
//    let type, publishedAt, createdAt, updatedAt: String
//    let amount: Double
//    let usersPermissionsUser, waste: Int
//    let earning: Double
//
//    enum CodingKeys: String, CodingKey {
//        case id, type
//        case publishedAt = "published_at"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case amount
//        case usersPermissionsUser = "users_permissions_user"
//        case waste, earning
//    }
//}
//
//
//struct SellTransactionB : Codable, Identifiable {
//    let id : Int
//    let amount : Double
//    let buyer : String
//    let earning : Double
//    let waste : Int
//    let publishedAt, createdAt, updatedAt: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, amount, buyer, earning, waste
//        case publishedAt = "published_at"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}



import Foundation

// MARK: - WasteElement
struct Waste: Codable, Identifiable {
    let id: Int
    let name, category: String
    let totalSavingAmount: Double
    let publishedAt, createdAt, updatedAt: String
    let savings, sellTransactions: [SavingW]

    enum CodingKeys: String, CodingKey {
        case id, name, category, totalSavingAmount
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case savings
        case sellTransactions = "sell_transactions"
    }
}

// MARK: - Saving
struct SavingW: Codable {
    let id: Int
    let type: String?
    let publishedAt, createdAt, updatedAt: String
    let amount: Double
    let usersPermissionsUser: Int?
    let waste: Int
    let earning: Double
    let buyer: String?

    enum CodingKeys: String, CodingKey {
        case id, type
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case amount
        case usersPermissionsUser = "users_permissions_user"
        case waste, earning, buyer
    }
}

//typealias Waste = [WasteElement]
