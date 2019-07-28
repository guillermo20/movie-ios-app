//
//  EndpointTypeProtocol.swift
//  MovieWebService
//
//  Created by Guillermo Gutierrez on 7/8/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation

public protocol Endpoint {
    var url: URL? { get }
    var categoryDescription: String { get }
}
