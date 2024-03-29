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
public struct WebServiceClient: Service {
    
    public init() {
        
    }
    
    private let apikey = PlistManager.shared.readPropertyString(propertyName: "ApiKey")
    
    /// a simple function that can be configured to either retrieve movies or series from the api
    ///
    /// - parameters:
    ///     - byCategory: look at `MovieEndpoint` for an example.
    ///     - withResponseType: Responses are defined in MoviesResponse and TVResponse classes
    public func loadData<ResponseT: Response>(byCategory: Endpoint, withResponseType: ResponseT.Type, withParameters: Parameters, completion: @escaping (ResponseT?, Error?) -> Void) {
        
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
            .responseJSON(queue: DispatchQueue.global()) { (response) in
                
                // if there is no data then we should call the completion closure with an error
                guard let data = response.data else {
                    DispatchQueue.main.async {
                        completion(nil, response.error)
                    }
                    return
                }
                
                // calls the completion closure with the response
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(withResponseType, from: data)
                    DispatchQueue.main.async {
                        completion(response, nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
        }
    
    }
    
    public func donwloadData(byCategory: Endpoint, completion: @escaping (Data?, Error?) -> Void) {
        
        guard let url = byCategory.url else {
            return
        }
        Alamofire.request(url)
            .validate()
            .response(queue: DispatchQueue.global()) { (response) in
                guard let data = response.data else {
                    DispatchQueue.main.async {
                        completion(nil, response.error)
                    }
                    return
                }
                DispatchQueue.main.async {
                    completion(data, nil)
                }
        }
        
    }
    
    public func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
}
