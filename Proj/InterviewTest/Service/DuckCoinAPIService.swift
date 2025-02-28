//
//  DuckCoinAPIService.swift
//  PrimerTest
//
//  Created by Frantiesco Masutti on 20/02/2025.
//

import Foundation

class DuckCoinAPIService {
    static let shared = DuckCoinAPIService()
    
    func fetchDuckCoinData(completion: @escaping (AppModel) -> Void) {
        if let appModel = loadJSON() {
            completion(appModel)
        }
    }
}
func loadJSON() -> AppModel? {
    guard let url = Bundle.main.url(forResource: "data", withExtension: "json"),
          let data = try? Data(contentsOf: url) else {
        return nil
    }
    let decoder = JSONDecoder()
    return try? decoder.decode(AppModel.self, from: data)
}
