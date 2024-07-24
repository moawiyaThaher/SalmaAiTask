//
//  CountriesAPI.swift
//  SalmaAiTask
//
//  Created by Moawiya Thaher on 22/07/2024.
//

import Foundation
import Alamofire

enum CountriesAPI: URLRequestConvertible {
    case fetchAllCountries
    
    var baseURL: String {
        return SalmaKeys.Networking.baseURL.rawValue
    }
    
    var path: String {
        switch self {
        case .fetchAllCountries:
            return "/v3.1/all"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchAllCountries:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }

    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL().appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        request.headers = headers ?? HTTPHeaders()
        return request
    }
}
