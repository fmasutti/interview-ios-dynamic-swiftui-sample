//
//  StartViewModel.swift
//  PrimerTest
//
//  Created by Frantiesco Masutti on 20/02/2025.
//

import Foundation
import Combine

class StartViewModel: ObservableObject {
    @Published var appModel: AppModel?
    @Published var components: [ComponentModel] = [ComponentModel]()
    @Published var duckCode: String = ""
    
    init() {
        DuckCoinAPIService.shared.fetchDuckCoinData { appModel in
            self.appModel = appModel
            self.components = appModel.screens[0].components
        }
    }
    
    func fetchDuckCoinData() {
        DuckCoinAPIService.shared.fetchDuckCoinData { appModel in
            self.appModel = appModel
        }
    }
    
    func payWithDucks() {
        print(duckCode)
    }
}

