//
//  Item.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 01/09/2025.
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
