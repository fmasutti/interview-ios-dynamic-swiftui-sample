//
//  ContentView.swift
//  PrimerTest
//
//  Created by Frantiesco Masutti on 20/02/2025.
//

import SwiftUI
import SwiftData
import Combine

import SwiftUI

struct StartView: View {
    @StateObject private var viewModel = StartViewModel()
    
    var body: some View {
        VStack {
            if $viewModel.components.isEmpty {
                Text("Loading...")
            } else {
                ForEach(viewModel.components, id: \.id) { component in
                    renderComponent(component)   
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchDuckCoinData()
        }
    }
    
    private func renderComponent(_ component: ComponentModel) -> AnyView {
        switch component.componentType {
        case "Form":
            return AnyView(
                VStack(spacing: CGFloat(component.gap ?? 0)) {
                    if let subComponents = component.components {
                        // FIXME: (JUST SWAP THE "componentType" TO id)
                        ForEach(subComponents, id: \.componentType) { subComponent in
                            renderComponent(subComponent)
                        }
                    }
                }
            )
        case "Container":
            return AnyView(
                VStack(spacing: CGFloat(component.gap ?? 0)) {
                    if let subComponents = component.components {
                        // FIXME: (JUST SWAP THE "componentType" TO id)
                        ForEach(subComponents, id: \.componentType) { subComponent in
                            renderComponent(subComponent)
                        }
                    }
                }
            )
        case "Text":
            if let text = component.text {
                return AnyView(Text(text))
            }   else {
                print( component)
            }
        case "Input":
            if let hint = component.hint, let label = component.label {
                return AnyView(
                    VStack(alignment: .leading) {
                        Text(label)
                        TextField(hint, text: $viewModel.duckCode)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                )
            }
        case "Button":
            if let text = component.text, component.type == "submit" {
                return AnyView(
                    Button(action: {
                        self.viewModel.payWithDucks()
                    }) {
                        Text(text)
                    }
                        .buttonStyle(DefaultButtonStyle())
                )
            }
        default:
            return AnyView(EmptyView())
        }
        return AnyView(EmptyView())
    }
}

#Preview {
    let mockedJSON = """
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
                      "text": "1. Go to your Ducks app to get your Duck code."
                    },
                    {
                      "componentType": "Text",
                      "text": "2. Paste your Duck code here."
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
                }
              ]
            }
          ]
        }
      ]
    }
    """
    let data = Data(mockedJSON.utf8)
    let decoder = JSONDecoder()
    let mockedAppModel = try? decoder.decode(AppModel.self, from: data)
    
    if let mockedAppModel = mockedAppModel {
        let viewModel = StartViewModel()
        viewModel.appModel = mockedAppModel
        viewModel.components = mockedAppModel.screens[0].components
        return StartView()
            .environmentObject(viewModel)
    } else {
        return StartView()
    }
}
