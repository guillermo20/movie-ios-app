//
//  DateFormat.swift
//  MovieDBRepository
//
//  Created by Guillermo Gutierrez on 7/26/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation

public extension String {
    
    func toDate(withFormat format: String = "yyyy-MM-dd")-> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
}

public extension Date {
    
    func toString(withFormat format: String = "yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        return str
    }
}
