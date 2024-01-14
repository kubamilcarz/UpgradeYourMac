//
//  Item.swift
//  UpgradeYourMac
//
//  Created by Kuba Milcarz on 1/14/24.
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
