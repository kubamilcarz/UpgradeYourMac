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
    @Query(sort: \BuildLog.timeStartedRecording, order: .reverse) var builds: [BuildLog]
    
    var body: some View {
        List(builds) { build in
            if build.title.starts(with: "Build") {
                Label("\(build.title) on \(build.dateStarted) took \(build.timeTaken) seconds", systemImage: "hammer.circle.fill")
                    .symbolRenderingMode(.hierarchical)
            } else {
                Label("\(build.title) on \(build.dateStarted) took \(build.timeTaken) seconds", systemImage: "paintbrush")
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    ContentView()
}
