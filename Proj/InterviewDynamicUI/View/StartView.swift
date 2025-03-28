//
//  ContentView.swift
//  InterviewDynamicUI
//
//  Created by Frantiesco Masutti on 20/02/2025.
//

import SwiftUI
import SwiftData
import Combine

// Just using a "StartView" to load and try the DyanamicUI flow
// but in theory we could have some other "base" class /protocol or even a modifier to load the dynamic content.

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


// Some mocked clas with a json bellow for the "fetchData".
// Created a "Slider" just to show case the Binding for Int/String. working as it should.
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
                            "componentType": "Slider",
                            "currentValue": 0.0,
                            "minValue": 0.0,
                            "maxValue": 100.0,
                            "label": "Show case slider",
                            "name": "sliderBindingKey"
                        },
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
                      "slider!": "{{sliderBindingKey}}"
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
