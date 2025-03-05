//
//  StartViewModel.swift
//  InterviewDynamicUI
//
//  Created by Frantiesco Masutti on 20/02/2025.
//

import Foundation
import Combine
import SwiftUI

class StartViewModel: DynamicViewProtocol {
    @Published var components: [ComponentModel] = []
    @Published var bindings: [String: Binding<Any>] = [:]
    @Published var events: [String: EventModel] = [:]
    var cancellables = Set<AnyCancellable>()

    init () {
        self.fetchDataAndHandle()
    }
    func fetchData() -> AnyPublisher<UIModel, Error> {
        return DuckCoinAPIService.shared.fetchDuckCoinData()
    }
}
