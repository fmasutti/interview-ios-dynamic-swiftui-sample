//
//  DuckCoinAPIService.swift
//  PrimerTest
//
//  Created by Frantiesco Masutti on 20/02/2025.
//

import Foundation
import Combine

class DuckCoinAPIService {
    static let shared = DuckCoinAPIService()
    
    private func loadJSON() -> Result<UIModel, Error> {
        guard let url = Bundle.main.url(forResource: "start-screen", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return .failure(NSError(domain: "LoadError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to load JSON file"]))
        }
        let decoder = JSONDecoder()
        
        // Description of the errors
        do {
            let uiModel = try decoder.decode(UIModel.self, from: data)
            return .success(uiModel)
        } catch let DecodingError.dataCorrupted(context) {
            return .failure(NSError(domain: "DecodingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data corrupted: \(context.debugDescription)"]))
        } catch let DecodingError.keyNotFound(key, context) {
            return .failure(NSError(domain: "DecodingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Key '\(key.stringValue)' not found: \(context.debugDescription)"]))
        } catch let DecodingError.typeMismatch(type, context) {
            return .failure(NSError(domain: "DecodingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Type '\(type)' mismatch: \(context.debugDescription)"]))
        } catch let DecodingError.valueNotFound(value, context) {
            return .failure(NSError(domain: "DecodingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Value '\(value)' not found: \(context.debugDescription)"]))
        } catch {
            return .failure(NSError(domain: "DecodingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Decoding error: \(error.localizedDescription)"]))
        }
    }
    
    func fetchDuckCoinData() -> AnyPublisher<UIModel, Error> {
        switch loadJSON() {
        case .success(let appModel):
            return Just(appModel)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}
