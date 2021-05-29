//
//  Movies.swift
//  MovieStore
//
//  Created by MAC on 29/05/2021.
//

import Foundation

// MARK: - Movies
struct Movies: Codable {
    let d: [D]
    let q: String
    let v: Int
}

// MARK: - D
struct D: Codable {
    let i: I?
    let id, l, q: String
    let rank: Int
    let s: String
    let v: [V]?
    let vt: Int?
    let y: Int
}

// MARK: - I
struct I: Codable {
    let height: Int
    let imageURL: String
    let width: Int

    enum CodingKeys: String, CodingKey {
        case height
        case imageURL = "imageUrl"
        case width
    }
}

// MARK: - V
struct V: Codable {
    let i: I
    let id, l, s: String
}
