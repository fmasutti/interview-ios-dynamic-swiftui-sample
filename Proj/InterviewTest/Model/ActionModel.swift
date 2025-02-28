//
//  ActionModel.swift
//  InterviewTest
//
//  Created by Frantiesco Masutti on 28/02/2025.
//

import Foundation

enum ActionType: Codable {
    case log
    case pay
    case fetch
    
    func functionName() {
        switch self {
        case .log:
            print("log")
        case .pay:
            // some Other Sample.
            return
        case .fetch:
            // some Other Sample.
            return
        }
    }
}

struct ActionModel: Codable {
    let type: String
    let args: [ArgModel]
}

