//
//  SalmaAPIServices.swift
//  SalmaAiTask
//
//  Created by Moawiya Thaher on 22/07/2024.
//

import Foundation
import Alamofire

class SalmaAPIServices: APIService {
    func requestData<T>(endpoint: any Alamofire.URLRequestConvertible, completion: @escaping (Result<T, any Error>) -> Void) where T : Decodable {
        do {
            let request = try endpoint.asURLRequest()
            AF.request(request).responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}

protocol APIService {
    func requestData<T: Decodable>(endpoint: URLRequestConvertible, completion: @escaping (Result<T, Error>) -> Void)
}
