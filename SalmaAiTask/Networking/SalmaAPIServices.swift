//
//  SalmaAPIs.swift
//  SalmaAiTask
//
//  Created by Moawiya Thaher on 22/07/2024.
//

import Foundation
import Alamofire

class APIService {
    func fetchAllCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
        do {
            let request = try CountriesAPI.fetchAllCountries.asURLRequest()
            AF.request(request).responseJSON { response in
                switch response.result {
                case .success(let data):
                    do {
                        let countries = try JSONDecoder().decode([Country].self, from: data as! Data)
                        completion(.success(countries))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}
