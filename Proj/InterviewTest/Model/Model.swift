//
//  Model.swift
//  PrimerTest
//
//  Created by Frantiesco Masutti on 20/02/2025.
//

import Foundation

struct AppModel: Codable {
    let screens: [ScreenModel]
    let events: [EventModel]
}

struct ScreenModel: Codable {
    let id: String
    let components: [ComponentModel]
}

struct ComponentModel: Codable {
    let id: String = UUID().uuidString
    let componentType: String
    let gap: Int? 
    let onSubmit: String?
    let components: [ComponentModel]?
    let text: String?
    let hint: String?
    let label: String?
    let name: String?
    let type: String? 
}

struct EventModel: Codable {
    let type: String
    let actions: [ActionModel]
}

struct ActionModel: Codable {
    let type: String
    let args: [ArgModel]
}

struct ArgModel: Codable {
    let duckCode: String
}
