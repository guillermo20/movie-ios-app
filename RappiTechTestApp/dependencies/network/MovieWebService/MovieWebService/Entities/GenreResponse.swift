//
//  GenreResponse.swift
//  MovieWebService
//
//  Created by Guillermo Gutierrez on 7/11/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation

// MARK: - GenereResponse
struct GenereResponse: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
