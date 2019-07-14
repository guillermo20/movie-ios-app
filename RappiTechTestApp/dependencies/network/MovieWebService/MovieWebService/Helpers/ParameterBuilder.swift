//
//  ParameterBuilder.swift
//  MovieWebService
//
//  Created by Guillermo Gutierrez on 7/11/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation

///note: apikey is not included here bc it is always required by the api so it is embedded into the network request
class ParameterBuilder {
    
    private var parameters: [String: Any]
    
    init() {
        parameters = [String: Any]()
    }
    
    @discardableResult
    func pageNumber(page: Int) -> ParameterBuilder {
        parameters["page"] = page
        return self
    }
    
    func build() -> [String: Any] {
        return parameters
    }
}
