//
//  CombineCountriesViewModel.swift
//  SalmaAiTask
//
//  Created by Moawiya Thaher on 24/07/2024.
//

import Foundation
import Combine

class CombineCountriesViewModel {
    
    // MARK: - Private Properties
    
    private let apiService: APIService
    private let databaseService = RealmManager.shared
    private var countries = CurrentValueSubject<[Country], Never>([])
    private var currentPage: Int = 0
    private let itemsPerPage: Int = 15
    
    // MARK: - Properties
    
    var displayedCountries = CurrentValueSubject<[Country], Never>([])
    
    // MARK: - Init
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    // MARK: - Methods
    
    func loadCountries() {
        if databaseService.isEmpty(Country.self) {
            apiService.requestData(endpoint: CountriesAPI.fetchAllCountries) { [weak self] (result: Result<[Country], Error>) in
                guard let self else { return }
                switch result {
                case .success(let countries):
                    databaseService.saveObjects(countries)
                    self.countries.send(countries)
                    loadNextPage()
                case .failure(let error):
                    print("Mewo Mewo: \(error)")
                }
            }
        } else {
            let savedContries = databaseService.retrieveObjects(Country.self) as? [Country] ?? []
            countries.send(savedContries)
            loadNextPage()
        }
    }
    
    func loadNextPage() {
        let startIndex = currentPage * itemsPerPage
        let endIndex = min(startIndex + itemsPerPage, countries.value.count)
        if startIndex < endIndex {
            let newItems = Array(countries.value[startIndex..<endIndex])
            
            
            
            var updatedCountries = displayedCountries.value
            updatedCountries.append(contentsOf: newItems)
            displayedCountries.send(updatedCountries)
            
            currentPage += 1
        }
    }
}
