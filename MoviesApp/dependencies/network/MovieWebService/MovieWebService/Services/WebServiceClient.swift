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
    ///
    /// - parameters:
    ///     - byCategory: look at `MovieEndpoint` for an example.
    ///     - withResponseType: Responses are defined in MoviesResponse and TVResponse classes
    public class func loadData<ResponseT: Response>(byCategory: Endpoint, withResponseType: ResponseT.Type, withParameters: Parameters = Parameters() , completion: @escaping (ResponseT?, Error?) -> Void) {
        
        guard let url = byCategory.url else {
            return
        }
        
        guard let apikey = self.apikey else {
            return
        }
        
        var parameters = withParameters
        parameters["api_key"] = apikey
        
        Alamofire.request(url, method: .get, parameters: parameters)
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
                    let response = try decoder.decode(withResponseType, from: data)
                    completion(response, nil)
                } catch {
                    completion(nil, error)
                }
        }
    
    }
    
}
