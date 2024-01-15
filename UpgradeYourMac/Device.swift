//
//  Device.swift
//  UpgradeYourMac
//
//  Created by Kuba Milcarz on 1/14/24.
//

import Foundation

struct Device: Hashable, Identifiable {
    var id: String { name }
    var name: String
    var performanceFactor: Double
    
    static let mbpM1Pro = Device(name: "M1 Pro Macbook Pro", performanceFactor: 1)
    static let mbpM1Max = Device(name: "M1 Max Macbook Pro", performanceFactor: 1.2)
    static let mbpM2Pro = Device(name: "M2 Pro Macbook Pro", performanceFactor: 1.2)
    static let mbpM2Max = Device(name: "M2 Max Macbook Pro", performanceFactor: 1.5)
    static let mbpM3Pro = Device(name: "M2 Pro Macbook Pro", performanceFactor: 1.5)
    static let mbpM3Max = Device(name: "M3 Max Macbook Pro", performanceFactor: 2)
    
    static let devices = [mbpM1Pro, mbpM1Max, mbpM2Pro, mbpM2Max, mbpM3Pro, mbpM3Max]
}
