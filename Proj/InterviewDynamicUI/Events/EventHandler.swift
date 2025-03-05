//
//  EventHandler.swift
//  InterviewDynamicUI
//
//  Created by Frantiesco Masutti on 03/03/2025.
//

import Foundation
import SwiftUI

// Protocol to handle events for easy testing
protocol EventHandlerProtocol {
    func handleEvent(_ event: EventModel)
}

class EventHandler: EventHandlerProtocol {
    private var bindings: [String: Binding<Any>]

    init(bindings: [String: Binding<Any>]) {
        self.bindings = bindings
    }

    func handleEvent(_ event: EventModel) {
        for action in event.actions {
            switch action.type {
            case .log:
                for arg in action.args {
                    if let binding = bindings[arg.key] {
                        if let value = binding.wrappedValue as? String {
                            print("\(arg.key): \(value)")
                        } else if let value = binding.wrappedValue as? Float {
                            print("\(arg.key): \(value)")
                        } else {
                            print("\(arg.key): \(binding.wrappedValue)")
                        }
                    }
                }
            }
        }
    }
}
