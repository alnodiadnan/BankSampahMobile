import Foundation

// MARK: - RequestCreationResponse
struct RequestCreationResponse: Codable {
    let id: Int
    let publishedAt, createdAt, updatedAt, status: String
    let usersPermissionsUser: UsersPermissionsUserReq
    let saveRequestDetails: [String]?

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

// MARK: - UsersPermissionsUser
struct UsersPermissionsUserReq: Codable {
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
