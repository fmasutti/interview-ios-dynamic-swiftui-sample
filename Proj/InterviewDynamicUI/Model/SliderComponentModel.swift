//
//  SliderComponentModel.swift
//  InterviewDynamicUI
//
//  Created by Frantiesco Masutti on 05/03/2025.
//

import Foundation

struct SliderComponentModel: Codable {
    let minValue: Float
    let maxValue: Float
    let currentValue: Float
    let label: String
    let name: String
}
