//
//  DynamicViewProtocol.swift
//  InterviewDynamicUI
//
//  Created by Frantiesco Masutti on 05/03/2025.
//

import Foundation
import Combine
import SwiftUI

protocol DynamicViewProtocol: ObservableObject {
    var components: [ComponentModel] { get set }
    var bindings: [String: Binding<String>] { get set }
    var events: [String: EventModel] { get set }
    var cancellables: Set<AnyCancellable> { get set }
    
    func fetchData() -> AnyPublisher<UIModel, Error>
}
