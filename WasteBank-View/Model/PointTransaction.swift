//
//  PointTransaction.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 14/07/21.
//
import Foundation

// MARK: - PointTransactionElement
struct PointTransaction: Codable, Identifiable {
    let id: Int
    let name: String
    let amount: Int
    let usersPermissionsUser: UsersPermissionsUserPoint
    let publishedAt, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name, amount
        case usersPermissionsUser = "users_permissions_user"
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - UsersPermissionsUser
struct UsersPermissionsUserPoint: Codable {
    let id: Int
    let username, email, provider: String
    let confirmed: Bool
    let blocked: String?
    let role: Int
    let createdAt, updatedAt, address, gender: String
    let fullname, type, birthDate: String
    let point: Int

    enum CodingKeys: String, CodingKey {
        case id, username, email, provider, confirmed, blocked, role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case address, gender, fullname, type, birthDate, point
    }
}
