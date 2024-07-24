//
//  CountryModel.swift
//  SalmaAiTask
//
//  Created by Moawiya Thaher on 22/07/2024.
//

import Foundation
import RealmSwift

class Country: Object, Codable {
    @objc dynamic var uuid: String? = UUID().uuidString
    @objc dynamic var name: Name? = nil
    @objc dynamic var flags: Flags? = nil
    let currencies = List<CurrencyKeyValue>()
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case currencies
        case flags
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(Name.self, forKey: .name)
        self.flags = try container.decodeIfPresent(Flags.self, forKey: .flags)
        
        let currenciesDict = try container.decodeIfPresent([String: Currency].self, forKey: .currencies)
        self.currencies.append(objectsIn: currenciesDict?.map { CurrencyKeyValue(key: $0.key, value: $0.value) } ?? [])
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(flags, forKey: .flags)
        
        let currenciesDict = Dictionary(uniqueKeysWithValues: currencies.map { ($0.key, $0.value) })
        try container.encodeIfPresent(currenciesDict, forKey: .currencies)
    }
}

class CurrencyKeyValue: Object, Codable {
    @objc dynamic var key: String = ""
    @objc dynamic var value: Currency? = nil
    
    convenience init(key: String, value: Currency?) {
        self.init()
        self.key = key
        self.value = value
    }
    
    enum CodingKeys: String, CodingKey {
        case key
        case value
    }
}

// MARK: - Currency

class Currency: Object, Codable {
    @objc dynamic var name: String? = ""
    @objc dynamic var symbol: String? = ""
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case symbol
    }
}

// MARK: - Name

class Name: Object, Codable {
    @objc dynamic var common: String? = ""
}

// MARK: - Flags

class Flags: Object, Codable {
    @objc dynamic var png: String? = ""
}
