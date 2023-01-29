//
//  RMCharactersResponse.swift
//  KornApps
//
//  Created by owner on 24/01/2023.
//

import Foundation

// MARK: - RMCharactersResponse
struct RMCharactersResponse: Codable {
    let info: RMInfo
    let results: [RMCharacter]
}

// MARK: - Info
struct RMInfo: Codable {
    let count, pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Result
struct RMCharacter: Codable {
    
    enum RMStatus: String, Codable {
        // 'Alive', 'Dead' or 'unknown'
        case alive = "Alive"
        case dead = "Dead"
        case unknown
    }
    
    enum Gender: String, Codable {
        case male = "Male"
        case female = "Female"
        case genderless = "Genderless"
        case unknown
    }
    
    let id: Int
    let name, species, type: String
    let status: RMStatus
    let gender: Gender
    let origin, location: RMLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - Location
struct RMLocation: Codable {
    let name: String
    let url: String
}
