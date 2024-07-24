//
//  CountriesViewModel.swift
//  SalmaAiTask
//
//  Created by Moawiya Thaher on 22/07/2024.
//

import Foundation
import RxSwift
import RxCocoa

class CountriesViewModel {
    
    // MARK: - Private Properties
    
    private let apiService: APIService
    private let databaseService = RealmManager.shared
    private var countries = BehaviorRelay<[Country]>(value: [])
    private var currentPage: Int = 0
    private let itemsPerPage: Int = 15
    
    // MARK: - Properties
    
    var displayedCountries = BehaviorRelay<[Country]>(value: [])
    
    // MARK: - Callbacks
    
    var onUpdate: (() -> Void)?
    
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
                    self.countries.accept(countries)
                    loadNextPage()
                case .failure(let error):
                    print("Mewo Mewo: \(error)")
                }
            }
        } else {
            let savedContries = databaseService.retrieveObjects(Country.self) as? [Country] ?? []
            countries.accept(savedContries)
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
            displayedCountries.accept(updatedCountries)
            
            currentPage += 1
            onUpdate?()
        }
    }
}
