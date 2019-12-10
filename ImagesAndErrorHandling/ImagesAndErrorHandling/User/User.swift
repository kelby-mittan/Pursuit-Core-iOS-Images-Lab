//
//  User.swift
//  ImagesAndErrorHandling
//
//  Created by Kelby Mittan on 12/7/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import Foundation

struct UserData: Decodable {
    let results: [Users]
}

struct Users: Decodable {
    let name: Name
    let email: String
    let location: Location
    let phone: String
    let dob: DOB
    let picture: Picture
    
}

struct Picture: Decodable {
    let large: String
    let thumbnail: String
    
    private enum CodingKeys: String, CodingKey {
        case large = "large"
        case thumbnail = "thumbnail"
    }
}

struct DOB: Decodable {
    let date: String
    let age: Int
}

struct Name: Decodable {
    let title: String
    let firstName: String
    let lastName: String
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    var fullNameReversed: String {
        "\(lastName) \(firstName)"
    }
    
    private enum CodingKeys: String, CodingKey {
        case title
        case firstName = "first"
        case lastName = "last"
    }
}

struct Location: Decodable {
    let street: Street
    let city: String
    let state: String
    let postcode: Postcode
}

struct Street: Codable {
    let number: Int
    let name: String
}

enum Postcode: Codable {
    func encode(to encoder: Encoder) throws {
        return
    }
    case int(Int), string(String)

    init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(int)
            return
        }

        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }

        throw QuantumError.missingValue
    }

    enum QuantumError:Error {
        case missingValue
    }
    
    func extractValue() -> String {
        var result = ""
        switch self {
        case .int(let value):
            result = value.description
        case .string(let valueStr):
            result = valueStr
        }
        return result
    }
}
