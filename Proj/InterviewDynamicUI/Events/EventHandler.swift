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
    private var bindings: [String: Binding<String>]

    init(bindings: [String: Binding<String>]) {
        self.bindings = bindings
    }

    func handleEvent(_ event: EventModel) {
        for action in event.actions {
            switch action.type {
            case .log:
                for arg in action.args {
                    if let value = bindings[arg.key] {
                        print("\(arg.key): \(value.wrappedValue)")
                    }
                }
            }
        }
    }
}
