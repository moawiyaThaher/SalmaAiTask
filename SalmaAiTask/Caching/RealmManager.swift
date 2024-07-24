//
//  RealmManager.swift
//  SalmaAiTask
//
//  Created by Moawiya Thaher on 22/07/2024.
//

import RealmSwift

class RealmManager {
    
    // MARK: - Properties
    
    static let shared = RealmManager()
    
    // MARK: - Private Properties
    
    private lazy var realm = try? Realm()
    
    // MARK: - Init
    
    private init() {}
    
    // MARK: - Methods
    
    func retrieveObjects(_ T: Object.Type) -> [Object] {
        guard let realm = realm else { return [] }
        var objects = [Object]()
        for item in realm.objects(T) {
            objects.append(item)
        }
        
        return objects
    }
    
    func saveObjects(_ objects: [Object], completion: (() -> Void)? = nil) {
        try? realm?.write {
            realm?.add(objects, update: .all)
            completion?()
        }
    }
    
    func isEmpty(_ object: Object.Type) -> Bool {
        guard let realm = self.realm else { return true }
        return realm.objects(object.self).isEmpty
    }
}
