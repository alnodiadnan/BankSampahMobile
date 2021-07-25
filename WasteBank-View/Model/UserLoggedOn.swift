//
//  UserLoggedOn.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 25/05/21.
//

//import Foundation
//
//// MARK: - UserLoggedOn
//struct UserLoggedOn: Codable {
//    let jwt: String
//    let user: User
//}
//
//// MARK: - User
//struct User: Codable {
//    let id: Int
//    let username, email, provider: String
//    let confirmed, blocked: Bool
//    let role: Role
//    let createdAt, updatedAt: String
//    let address, gender, fullname: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, username, email, provider, confirmed, blocked, role, address, gender, fullname
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}
//
//// MARK: - Role
//struct Role: Codable {
//    let id: Int
//    let name, roleDescription, type: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case roleDescription = "description"
//        case type
//    }
//}
//


import Foundation

// MARK: - UserLoggedOn
struct UserLoggedOn: Codable {
    let jwt: String
    let user: User
}

// MARK: - User
struct User: Codable {
    let id: Int
    let username, email, provider: String
    let confirmed: Bool
    let blocked: String?
    let role: Role
    let createdAt, updatedAt, address, gender: String
    let fullname, type: String
    let birthDate : String
    let point : Int
    let phoneNumber : String

    enum CodingKeys: String, CodingKey {
        case id, username, email, provider, confirmed, blocked, role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case address, gender, fullname, type, birthDate, point, phoneNumber
    }
}

// MARK: - Role
struct Role: Codable {
    let id: Int
    let name, roleDescription, type: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case roleDescription = "description"
        case type
    }
}

class UserLoggedOnInfo : ObservableObject {
    @Published var id : Int = 0
    @Published var username : String = "*Nama Akun*"
    @Published var fullname : String = "*Nama Lengkap*"
    @Published var email : String = "*Email*"
    @Published var joinDate: String = "*Tanggal Join*"
    @Published var gender: String = "*Jenis Kelamin*"
    @Published var address: String = "*Alamat*"
    @Published var type: String = "Member"
    @Published var birthDate : String = "*Tanggal Lahir*"
    @Published var point : Int = 0
    @Published var phoneNumber : String = "*Nomor Telepon*"
    
    @Published var isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
}
