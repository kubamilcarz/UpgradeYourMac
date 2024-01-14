//
//  ContentView.swift
//  UpgradeYourMac
//
//  Created by Kuba Milcarz on 1/14/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var watcher = BuildWatcher()
    
    var body: some View {
        Text("Hi")
    }
}

#Preview {
    ContentView()
}
