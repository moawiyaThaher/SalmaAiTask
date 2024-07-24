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
        let apiService = SalmaAPIService()
        
//        /// RxSwift example
//        let viewModel = CountriesViewModel(apiService: apiService)
//        let viewController = CountriesViewController(viewModel: viewModel)
//        navigationController?.pushViewController(viewController, animated: true)
//        
        /// Combine example
        let viewModel = CombineCountriesViewModel(apiService: apiService)
        let viewController = CombineCountriesViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
