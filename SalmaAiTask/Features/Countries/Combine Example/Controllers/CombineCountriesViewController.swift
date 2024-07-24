//
//  CombineCountriesViewController.swift
//  SalmaAiTask
//
//  Created by Moawiya Thaher on 24/07/2024.
//

import UIKit
import Combine

class CombineCountriesViewController: UIViewController {
    
    // MARK: - Views
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Private Properties
    
    private let viewModel: CombineCountriesViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: CombineCountriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        addConstraints()
        setupNavigationItem()
        setupTableView()
        bindTableView()
        loadData()
    }
    
    // MARK: - Private Methods
    
    private func addViews() {
        view.addSubview(tableView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.register(CountryTVC.self, forCellReuseIdentifier: CountryTVC.identifier)
    }
    
    private func bindTableView() {
        viewModel.displayedCountries
            .sink { [weak self] _ in
                guard let self else { return }
                reloadData()
            }
            .store(in: &cancellables)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func loadData() {
        viewModel.loadCountries()
    }
    
    private func reloadData() {
        tableView.reloadData()
    }
    
    private func setupNavigationItem() {
        navigationItem.rightBarButtonItem = .init(image: .init(systemName: "magnifyingglass"))
        navigationItem.title = "Countries - Currency"
    }
}

extension CombineCountriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.displayedCountries.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTVC.identifier, for: indexPath) as! CountryTVC
        let item = viewModel.displayedCountries.value[indexPath.row]
        cell.configure(country: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.displayedCountries.value.count - 1 { 
            viewModel.loadNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
