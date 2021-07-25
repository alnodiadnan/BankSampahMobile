//
//  SellTransaction.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 20/06/21.
//

import Foundation

struct SellTransaction : Codable, Identifiable {
    let id : Int
    let amount : Double
    let buyer : String
    let earning : Double
    let waste : WasteSell
    let publishedAt, createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, amount, buyer, earning, waste
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct WasteSell: Codable , Identifiable {
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
