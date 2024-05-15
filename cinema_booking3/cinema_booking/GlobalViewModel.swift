//
//  GlobalViewModel.swift
//  cinema_booking
//
//  Created by apple on 2024/5/13.
//

import Foundation

class GlobalViewModel: ObservableObject {
    @Published var showDetails = false
    @Published var selectedIndex = 0
    init() {
        
    }
}
