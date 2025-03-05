//
//  ContainerComponentModel.swift
//  InterviewDynamicUI
//
//  Created by Frantiesco Masutti on 04/03/2025.
//

import Foundation

struct ContainerComponentModel: Codable {
    let gap: Int?
    let components: [ComponentModel]
}
