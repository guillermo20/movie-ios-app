//
//  Service.swift
//  Alamofire
//
//  Created by Guillermo Gutierrez on 7/14/19.
//

import Foundation
import Alamofire

public protocol Service {

    func loadData<ResponseT: Response>(byCategory: Endpoint, withResponseType: ResponseT.Type, withParameters: Parameters, completion: @escaping (ResponseT?, Error?) -> Void)

    func isConnectedToInternet() -> Bool

}

public extension Service {

    func loadData<ResponseT: Response>(byCategory: Endpoint, withResponseType: ResponseT.Type, withParameters: Parameters = Parameters(), completion: @escaping (ResponseT?, Error?) -> Void) {
//        return loadData(byCategory: byCategory, withResponseType: withResponseType, withParameters: withParameters, completion: completion)
    }

}
