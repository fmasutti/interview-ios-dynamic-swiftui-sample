//
//  UIModel.swift
//  InterviewDynamicUI
//
//  Created by Frantiesco Masutti on 04/03/2025.
//

import Foundation

struct UIModel: Codable {
    let screens: [ScreenModel]
    let events: [EventModel]
}
