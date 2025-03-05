//
//  EventModel.swift
//  InterviewDynamicUI
//
//  Created by Frantiesco Masutti on 04/03/2025.
//

import Foundation

struct EventModel: Codable {
    let type: String
    let actions: [ActionModel]
}
