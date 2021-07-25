//
//  MemberTest.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 24/05/21.
//

import Foundation

// MARK: - MemberTestElement
struct MemberTestElement: Codable {
    let id: Int
    let username, publishedAt, createdAt, updatedAt: String
    let profilePicture: ProfilePicture?

    enum CodingKeys: String, CodingKey {
        case id, username
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case profilePicture
    }
}

// MARK: - ProfilePicture
struct ProfilePicture: Codable {
    let id: Int
    let name, alternativeText, caption: String
    let width, height: Int
    let formats: Formats
    let hash, ext, mime: String
    let size: Double
    let url: String
    let previewURL: String?
    let provider: String
    let providerMetadata: String?
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name, alternativeText, caption, width, height, formats, hash, ext, mime, size, url
        case previewURL = "previewUrl"
        case provider
        case providerMetadata = "provider_metadata"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Formats
struct Formats: Codable {
    let large, small, medium, thumbnail: Large
}

// MARK: - Large
struct Large: Codable {
    let ext, url, hash, mime: String
    let name: String
    let path: String?
    let size: Double
    let width, height: Int
}

typealias MemberTest = [MemberTestElement]
