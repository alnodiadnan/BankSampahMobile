//
//  SavingTransaction.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 09/06/21.
//

//import Foundation
//
//// MARK: - Saving
//struct SavingTransaction: Codable, Identifiable {
//    let id: Int
//    let amount: Double
//    let type: String
//    let saving: SavingB
//    let publishedAt, createdAt, updatedAt: String
//    let earning : Double
//    //let usersPermissionsUser: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id, amount, type, saving, earning
//        case publishedAt = "published_at"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        //case usersPermissionsUser = "users_permissions_user"
//    }
//
////    init(id: Int, amount: Double, type: String, saving: Saving?, publishedAt: String, createdAt: String, updatedAt: String, usersPermissionsUser: Int?) {
////        self.id = id
////        self.amount = amount
////        self.type = type
////        self.saving = saving
////        self.publishedAt = publishedAt
////        self.createdAt = createdAt
////        self.updatedAt = updatedAt
////        self.usersPermissionsUser = usersPermissionsUser
////    }
//}
//
//struct SavingB: Codable, Identifiable {
//    let id: Int
//    let type, publishedAt, createdAt, updatedAt: String
//    let amount: Double
//    let usersPermissionsUser: Int
//    let waste: Int
//    let earning: Double
//
//    enum CodingKeys: String, CodingKey {
//        case id, type, earning, waste
//        case publishedAt = "published_at"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case amount
//        case usersPermissionsUser = "users_permissions_user"
//    }
//}
//


import Foundation

// MARK: - Saving
struct SavingTransaction: Codable, Identifiable {
    let id: Int
    let amount: Double
    let type: String
    let saving: SavingT
    let publishedAt, createdAt, updatedAt: String
    let earning: Double
    
    enum CodingKeys: String, CodingKey {
        case id, amount, type, saving
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case earning
    }
}

struct SavingT: Codable {
    let id: Int
    let type: String
    let amount: Double
    let usersPermissionsUser, waste: Int
    let publishedAt, createdAt, updatedAt: String
    let earning: Double
    
    enum CodingKeys: String, CodingKey {
        case id, amount, type
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case usersPermissionsUser = "users_permissions_user"
        case earning, waste
    }
}


