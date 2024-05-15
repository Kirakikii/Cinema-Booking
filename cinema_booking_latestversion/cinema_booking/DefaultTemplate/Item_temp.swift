//
//  Item.swift
//  cinema_booking
//
//  Created by 吴泓昕 on 5/8/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
