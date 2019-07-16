//
//  GenreResponse.swift
//  MovieWebService
//
//  Created by Guillermo Gutierrez on 7/11/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation

// MARK: - GenereResponse
public struct GenreResponse: Response {
    public let genres: [GenreType]
}

// MARK: - Genre
public struct GenreType: Codable {
    public let id: Int
    public let name: String
}
