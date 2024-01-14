//
//  UpgradeYourMacApp.swift
//  UpgradeYourMac
//
//  Created by Kuba Milcarz on 1/14/24.
//

import SwiftUI
import SwiftData

@main
struct UpgradeYourMacApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: BuildLog.self)
    }
}
