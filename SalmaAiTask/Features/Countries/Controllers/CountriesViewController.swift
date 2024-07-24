//
//  CountriesViewController.swift
//  SalmaAiTask
//
//  Created by Moawiya Thaher on 22/07/2024.
//

import UIKit
import RxSwift
import RxCocoa

class CountriesViewController: UIViewController {
    
    // MARK: - Views
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Private Properties
    
    private let viewModel: CountriesViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    init(viewModel: CountriesViewModel) {
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
        
        viewModel.onUpdate = { [weak self] in
            self?.reloadData()
        }
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
        viewModel.displayedCountries.bind(to: tableView.rx.items(cellIdentifier: "CountryTVC", cellType: CountryTVC.self)) { (_, country: Country, cell) in
            cell.configure(country: country)
        }.disposed(by: disposeBag)
        
        tableView.rx.willDisplayCell.subscribe { [weak self] _, indexPath in
            guard let self = self else { return }
            if indexPath.row == self.viewModel.displayedCountries.value.count - 1 {
                self.viewModel.loadNextPage()
            }
        }.disposed(by: disposeBag)
    }
    
    private func loadData() {
        viewModel.loadCountries()
    }
    
    private func reloadData() {
        tableView.reloadData()
    }
    
    private func setupNavigationItem() {
        navigationItem.rightBarButtonItem = .init(image: .init(systemName: "magnifier"))
        navigationItem.title = "Countries - Currency"
    }
}


extension CountriesViewController: UITableViewDelegate {
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
