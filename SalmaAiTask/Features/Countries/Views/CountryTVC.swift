//
//  CountryTVC.swift
//  SalmaAiTask
//
//  Created by Moawiya Thaher on 23/07/2024.
//

import UIKit

class CountryTVC: UITableViewCell {

    // MARK: - Properites
    
    static let identifier = "CountryTVC"
    
    // MARK: - Views
    
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()
    
   private let currencyCodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()
    
   private let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }

    // MARK: - Methods
    
    func configure(country: Country) {
        let name = country.name?.common ?? ""
        let currencies = country.currencies.compactMap({ currency in
            return currency.value?.name
        })
        let currenciesFormatted = currencies.joined(separator: ", ")
        
        let currencyCodes = country.currencies.compactMap({ currency in
            return currency.key
        })
        
        let currencyCodesFormatted = currencyCodes.joined(separator: ", ")
        
        nameLabel.text = "Name: \(name)"
        currencyLabel.text = "Currencies: \(currenciesFormatted)"
        currencyCodeLabel.text = "Currency Codes: \(currencyCodesFormatted)"
        flagImageView.loadImage(urlString: country.flags?.png)
    }

    // MARK: - Private Methods
    
    private func addViews() {
        addSubview(flagImageView)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(currencyLabel)
        stackView.addArrangedSubview(currencyCodeLabel)
        
        addSubview(stackView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            flagImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            flagImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            flagImageView.widthAnchor.constraint(equalToConstant: 60),
            flagImageView.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor, constant: 18),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
}
