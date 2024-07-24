//
//  CountriesViewModel.swift
//  SalmaAiTask
//
//  Created by Moawiya Thaher on 22/07/2024.
//

import Foundation

class CountriesViewModel {
    private let apiService = APIService()
    private let databaseService = RealmManager.shared
    
    var countries: [Country] = []
    var currentPage: Int = 0
    let itemsPerPage: Int = 15
    
    var onUpdate: (() -> Void)?
    
    func loadCountries() {
        if databaseService.isEmpty(Country.self) {
            apiService.fetchAllCountries() { [weak self] result in
                switch result {
                case .success(let countries):
                    self?.databaseService.saveObjects(countries)
                    self?.countries = countries
                    self?.onUpdate?()
                case .failure(let error):
                    print("Error fetching countries: \(error)")
                }
            }
        } else {
            countries = databaseService.retrieveObjects(Country.self) as? [Country] ?? []
            onUpdate?()
        }
    }
    
    func loadNextPage() {
        let start = currentPage * itemsPerPage
        let end = start + itemsPerPage
        let nextPageItems = Array(countries[start..<min(end, countries.count)])
        currentPage += 1
        // Append nextPageItems to the current displayed data
        // Update the UI with onUpdate callback
    }
}
