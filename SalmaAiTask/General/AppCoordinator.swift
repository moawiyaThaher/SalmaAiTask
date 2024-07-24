//
//  AppCoordinator.swift
//  SalmaAiTask
//
//  Created by Moawiya Thaher on 23/07/2024.
//

import Foundation
import UIKit

class AppCoordinator {
    
    var navigationController: UINavigationController?
        
    func start() {
        startCountriesFlow()
    }
    
    // MARK: - Private Methods
    
    private func startCountriesFlow() {
        rxExample()
    }
    
    private func rxExample() {
        let apiService = SalmaAPIService()
        let viewModel = CountriesViewModel(apiService: apiService)
        let viewController = CountriesViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func combineExample() {
        let apiService = SalmaAPIService()
        let viewModel = CombineCountriesViewModel(apiService: apiService)
        let viewController = CombineCountriesViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
