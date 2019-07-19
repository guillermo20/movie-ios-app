//
//  DependencyInjector.swift
//  MoviesApp
//
//  Created by Guillermo Gutierrez on 7/19/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation

struct DependencyInjector {
    static var dependencies: Dependency = DependencyHandler()
    private init() { }
}
