//
//  FormComponentModel.swift
//  InterviewDynamicUI
//
//  Created by Frantiesco Masutti on 04/03/2025.
//

import Foundation

struct FormComponentModel: Codable {
    let gap: Int?
    let onSubmit: String
    let components: [ComponentModel]
}
