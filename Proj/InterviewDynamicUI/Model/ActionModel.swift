//
//  ActionModel.swift
//  InterviewTest
//
//  Created by Frantiesco Masutti on 28/02/2025.
//

import Foundation

struct ActionModel: Codable {
    let type: ActionType
    let args: [ActionArgumentModel]
}

enum ActionType: String, Codable {
    case log
    // Add other action types as needed
}

struct ActionArgumentModel: Codable {
    let key: String
    let value: String
    
    init(key: String, value: String) {
        self.key = key
        self.value = value
    }
    
    // Custom initializer to decode a dictionary into the key-value pair
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        // Decode the dictionary to get the first key-value pair
        let dict = try container.decode([String: String].self)
        
        guard let first = dict.first else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Expected dictionary with at least one key-value pair.")
        }
        
        self.key = first.key
        self.value = first.value
    }
    
    // Custom encode function to turn it back into a dictionary with one key-value pair
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode([key: value])
    }
}
