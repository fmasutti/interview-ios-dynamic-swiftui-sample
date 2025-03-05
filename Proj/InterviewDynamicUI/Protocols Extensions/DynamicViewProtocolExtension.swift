//
//  DynamicViewProtocolExtension.swift
//  InterviewDynamicUI
//
//  Created by Frantiesco Masutti on 05/03/2025.
//

import Foundation
import Combine
import SwiftUI

extension DynamicViewProtocol {
    
    func fetchDataAndHandle() {
        fetchData()
            .receive(on: DispatchQueue.main) // Ensure UI updates happen on the main thread
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching data: \(error.localizedDescription)")
                }
            }, receiveValue: { uiModel in
                self.handleFetchedData(uiModel)
            })
            .store(in: &cancellables)
    }
    
    func handleFetchedData(_ uiModel: UIModel) {
        self.components = uiModel.screens.first?.components ?? []
        self.bindings = initializeBindings(for: self.components)
        self.events = uiModel.events.reduce(into: [:]) { $0[$1.type] = $1 }
    }
    
    // Initialize bindings for the components any "named" inside the component is handled as a binding.
    private func initializeBindings(for components: [ComponentModel]) -> [String: Binding<String>] {
        var bindings: [String: Binding<String>] = [:]

        for component in components {
            switch component.componentType {
            case .input(let inputModel):
                var value = ""
                let binding = Binding<String>(
                    get: { value },
                    set: { newValue in value = newValue }
                )
                bindings[inputModel.name] = binding

            case .form(let formModel):
                let nestedBindings = initializeBindings(for: formModel.components)
                bindings.merge(nestedBindings) { (_, new) in new }

            case .container(let containerModel):
                let nestedBindings = initializeBindings(for: containerModel.components)
                bindings.merge(nestedBindings) { (_, new) in new }

            default:
                break
            }
        }
        return bindings
    }
}
