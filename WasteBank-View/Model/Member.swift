//
//  Member.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 07/05/21.
//

//import Foundation
//import SwiftUI

//struct Member : Hashable, Codable, Identifiable {
//    var id : Int
//    var username : String
//    //var dataOfBirth: String
//    var createdAt : String
//
////    private var profilePictureName : String = "Placeholder_MemberProfilePicture"
////    var profilePicture : Image {
////        Image(profilePictureName)
////    }
//
//    enum CodingKeys: String, CodingKey {
//        case id, username
//        case createdAt = "created_at"
//    }
//}

import Foundation

// MARK: - MemberElement
struct Member: Codable, Identifiable {
    let id: Int
    let username, email, provider: String
    let confirmed: Bool
    let blocked: String?
    let role: Role
    let createdAt, updatedAt, address, gender: String
    let fullname, type: String

    enum CodingKeys: String, CodingKey {
        case id, username, email, provider, confirmed, blocked, role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case address, gender, fullname, type
    }
}




