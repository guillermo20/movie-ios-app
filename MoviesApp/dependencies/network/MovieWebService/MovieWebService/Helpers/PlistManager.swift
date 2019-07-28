//
//  PlistManager.swift
//  MovieWebService
//
//  Created by Guillermo Gutierrez on 7/7/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation

class PlistManager {
    
    static let shared = PlistManager()
    
    private let resourceName = "webservice"
    
    private init() {
        
    }
    
    func readPropertyString(propertyName: String) -> String? {
        guard let URL = Bundle(for: type(of: self)).url(forResource: resourceName, withExtension: "plist") else {
            print("I was not able to find resource file")
            return nil
        }
        guard let fileContent = NSDictionary(contentsOf: URL) as? [String: Any] else {
            print("I was not able to read content and convert it into [String: Any]")
            return nil
        }
        
        return fileContent[propertyName] as? String
    }
}
