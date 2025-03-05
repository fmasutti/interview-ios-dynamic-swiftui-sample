//
//  ContentView.swift
//  PrimerTest
//
//  Created by Frantiesco Masutti on 20/02/2025.
//

import SwiftUI
import SwiftData
import Combine

// Assuming that all classes would have the same layout structure, it would be possible to create a base class / protocol / ViewModifier that could be used to create the core of view.
struct StartView: View {
    @StateObject private var viewModel = StartViewModel()
    
    // Dependency Injection for testing
    init(viewModel: StartViewModel = StartViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            if $viewModel.components.isEmpty {
                Text("Loading...")
            } else {
                ForEach(viewModel.components, id: \.id) { component in
                    UIFactory.createView(from: component, bindings: viewModel.bindings, events: viewModel.events)
                }
            }
        }
    }
}

private class StartViewModelMocked: StartViewModel {
    override func fetchData() -> AnyPublisher<UIModel, any Error> {
        let jsonString =
        """
        {
          "screens": [
            {
              "id": "start-screen",
              "components": [
                {
                  "componentType": "Form",
                  "gap": 4,
                  "onSubmit": "PAY_WITH_DUCKS",
                  "components": [
                    {
                      "componentType": "Container",
                      "gap": 2,
                      "components": [
                        {
                          "componentType": "Text",
                          "text": "Pay with Ducks"
                        },
                        {
                          "componentType": "Text",
                          "text": "1. Open your Ducks app to get your Duck code."
                        },
                        {
                          "componentType": "Text",
                          "text": "2. Enter your Duck code below."
                        },
                        {
                          "componentType": "Input",
                          "hint": "1234",
                          "label": "Duck code",
                          "name": "duckCode"
                        }
                      ]
                    },
                    {
                      "componentType": "Container",
                      "gap": 50,
                      "components": [
                        {
                          "componentType": "Text",
                          "text": "Pay with Dogs"
                        },
                        {
                          "componentType": "Text",
                          "text": "1. Open your Dogs app to get your Dog code."
                        },
                        {
                          "componentType": "Text",
                          "text": "2. Enter your Dog code below."
                        },
                        {
                          "componentType": "Input",
                          "hint": "5678",
                          "label": "Dog code",
                          "name": "dogCode"
                        }
                      ]
                    },
                    {
                      "componentType": "Button",
                      "type": "submit",
                      "text": "Pay"
                    }
                  ]
                }
              ]
            }
          ],
          "events": [
            {
              "type": "PAY_WITH_DUCKS",
              "actions": [
                {
                  "type": "log",
                  "args": [
                    {
                      "duckCode": "{{duckCode}}"
                    },
                    {
                      "dogCode": "{{dogCode}}"
                    }
                  ]
                }
              ]
            }
          ]
        }
        """
        do {
            let jsonData = jsonString.data(using: .utf8)!
            let sampleUIModel = try JSONDecoder().decode(UIModel.self, from: jsonData)
            return Just(sampleUIModel)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}

#Preview {
    StartView(viewModel: StartViewModelMocked())
}
