// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let saveRequestHeader = try? newJSONDecoder().decode(SaveRequestHeader.self, from: jsonData)

import Foundation

// MARK: - SaveRequestHeaderElement
struct SaveRequestHeader: Codable, Identifiable {
    let id: Int
    let publishedAt, createdAt, updatedAt, status: String
    let usersPermissionsUser: UsersPermissionsUserHeader
    let saveRequestDetails: [SaveRequestDetail]

    enum CodingKeys: String, CodingKey {
        case id
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case status
        case usersPermissionsUser = "users_permissions_user"
        case saveRequestDetails = "save_request_details"
    }
}

// MARK: - SaveRequestDetail
struct SaveRequestDetail: Codable, Identifiable {
    let id, saveRequestHeader: Int
    let wasteName: String
    let amount: Double
    let publishedAt, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case saveRequestHeader = "save_request_header"
        case wasteName, amount
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - UsersPermissionsUser
struct UsersPermissionsUserHeader: Codable {
    let id: Int
    let username, email, provider: String
    let confirmed: Bool
    let blocked: String?
    let role: Int
    let createdAt, updatedAt, address, gender: String
    let fullname, type, birthDate: String
    let point: Int
    let phoneNumber: String

    enum CodingKeys: String, CodingKey {
        case id, username, email, provider, confirmed, blocked, role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case address, gender, fullname, type, birthDate, point, phoneNumber
    }
}
