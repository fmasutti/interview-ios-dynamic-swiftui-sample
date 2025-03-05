//
//  ComponentModel.swift
//  PrimerTest
//
//  Created by Frantiesco Masutti on 20/02/2025.
//

import Foundation

struct ComponentModel: Codable {
    var id: String
    let componentType: ComponentType

    init(componentType: ComponentType) {
        self.id = UUID().uuidString
        self.componentType = componentType
    }

    enum CodingKeys: String, CodingKey {
        case id
        case componentType
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        let componentTypeString = try container.decode(String.self, forKey: .componentType)
        
        // Map the string to the appropriate ComponentType case
        switch componentTypeString {
        case "Form":
            let formComponent = try FormComponentModel(from: decoder)
            self.componentType = .form(formComponent)
        case "Container":
            let containerComponent = try ContainerComponentModel(from: decoder)
            self.componentType = .container(containerComponent)
        case "Text":
            let textComponent = try TextComponentModel(from: decoder)
            self.componentType = .text(textComponent)
        case "Input":
            let inputComponent = try InputComponentModel(from: decoder)
            self.componentType = .input(inputComponent)
        case "Button":
            let buttonComponent = try ButtonComponentModel(from: decoder)
            self.componentType = .button(buttonComponent)
        case "Slider":
                    let sliderComponent = try SliderComponentModel(from: decoder)
                    self.componentType = .slider(sliderComponent)
        default:
            throw DecodingError.dataCorruptedError(forKey: .componentType, in: container, debugDescription: "Unknown component type: \(componentTypeString)")
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        
        // Convert componentType to its associated string value for encoding
        let componentTypeString: String
        switch self.componentType {
        case .form:
            componentTypeString = "Form"
        case .container:
            componentTypeString = "Container"
        case .text:
            componentTypeString = "Text"
        case .input:
            componentTypeString = "Input"
        case .button:
            componentTypeString = "Button"
        case .slider:
            componentTypeString = "Slider"
        }
        
        try container.encode(componentTypeString, forKey: .componentType)
    }
}

enum ComponentType: Codable {
    case form(FormComponentModel)
    case container(ContainerComponentModel)
    case text(TextComponentModel)
    case input(InputComponentModel)
    case button(ButtonComponentModel)
    case slider(SliderComponentModel)

    enum CodingKeys: String, CodingKey {
        case form = "Form"
        case container = "Container"
        case text = "Text"
        case input = "Input"
        case button = "Button"
        case slider = "Slider"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let form = try? container.decode(FormComponentModel.self, forKey: .form) {
            self = .form(form)
        } else if let container = try? container.decode(ContainerComponentModel.self, forKey: .container) {
            self = .container(container)
        } else if let text = try? container.decode(TextComponentModel.self, forKey: .text) {
            self = .text(text)
        } else if let input = try? container.decode(InputComponentModel.self, forKey: .input) {
            self = .input(input)
        } else if let button = try? container.decode(ButtonComponentModel.self, forKey: .button) {
            self = .button(button)
        } else if let slider = try? container.decode(SliderComponentModel.self, forKey: .slider) {
            self = .slider(slider)
        } else {
            throw DecodingError.dataCorruptedError(forKey: .form, in: container, debugDescription: "Invalid component type")
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .form(let form):
            try container.encode(form, forKey: .form)
        case .container(let containerModel):
            try container.encode(containerModel, forKey: .container)
        case .text(let text):
            try container.encode(text, forKey: .text)
        case .input(let input):
            try container.encode(input, forKey: .input)
        case .button(let button):
            try container.encode(button, forKey: .button)
        case .slider(let slider):
            try container.encode(slider, forKey: .slider)
        }
    }
}
