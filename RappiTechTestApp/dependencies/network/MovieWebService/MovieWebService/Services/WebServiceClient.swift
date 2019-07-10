//
//  MovieDBService.swift
//  MovieWebService
//
//  Created by Guillermo Gutierrez on 7/6/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import Foundation
import Alamofire

/// implements calls to the movie db api services
public class WebServiceClient {
    
    private static let apikey = PlistManager.shared.readPropertyString(propertyName: "ApiKey")
    
    /// a simple function that can be configured to either retrieve movies or series from the api
    public class func loadData<EndpointT: Endpoint, ResponseT: Response>(byCategory: EndpointT, withResponseType: ResponseT.Type, pageNumber: Int = 1, completion: @escaping (ResponseT?, Error?) -> Void) {
        
        guard let url = byCategory.url else {
            return
        }
        
        guard let apikey = self.apikey else {
            return
        }
        
        Alamofire.request(url, method: .get, parameters: ["api_key": apikey, "page": pageNumber])
            .validate()
            .responseJSON { (response) in
                
                // if there is no data then we should call the completion closure with an error
                guard let data = response.data else {
                    completion(nil, response.error)
                    return
                }
                
                // calls the completion closure with the response
                do {
                    let decoder = JSONDecoder()
                    let movieResponse = try decoder.decode(withResponseType, from: data)
                    completion(movieResponse, nil)
                } catch {
                    completion(nil, error)
                }
        }
    
    }
    
}
