//
//  FriendListResponseModel.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//

import Foundation


// MARK: - FriendListResponseModel
struct FriendsListResponseModel: Codable {
    let results: [FriendsListResponseData]?
    let info: Info?
}

// MARK: - Info
struct Info: Codable {
    let seed: String?
    let results, page: Int?
    let version: String?
}

// MARK: - Result
struct FriendsListResponseData: Codable {
    let gender: String?
    let name: Name?
    let location: Location?
    let email: String?
    let login: Login?
    let dob, registered: Dob?
    let phone, cell: String?
    let id: ID?
    let picture: Picture?
    let nat: String?
}

// MARK: - Dob
struct Dob: Codable {
    let date: String?
    let age: Int?
}


// MARK: - ID
struct ID: Codable {
    let name: String?
    let value: String?
}

// MARK: - Location
struct Location: Codable {
    let street: Street?
    let city, state, country: String?
    let postcode: Postcode?
    let coordinates: Coordinates?
    let timezone: Timezone?
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: String?
}

enum Postcode: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Postcode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Postcode"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Street
struct Street: Codable {
    let number: Int?
    let name: String?
}

// MARK: - Timezone
struct Timezone: Codable {
    let offset, description: String?
}

// MARK: - Login
struct Login: Codable {
    let uuid, username, password, salt: String?
    let md5, sha1, sha256: String?
}

// MARK: - Name
struct Name: Codable {
    let title: String?
    let first, last: String?
}


// MARK: - Picture
struct Picture: Codable {
    let large, medium, thumbnail: String?
}
