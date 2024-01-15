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
    @Environment(\.modelContext) var modelContext
    
    @State private var currentDevice = Device.mbpM1Pro
    @State private var targetDevice = Device.mbpM3Pro
    @State private var hourlyRate = 30
    
    var savedSeconds: Double {
        let totalCurrentTime = builds.map(\.timeTaken).reduce(0, +)
        let totalUpgradedTime = totalCurrentTime / targetDevice.performanceFactor * currentDevice.performanceFactor
        return totalCurrentTime - totalUpgradedTime
    }
    
    var savedTime: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.month, .weekOfMonth, .day, .hour, .minute, .second]
        formatter.unitsStyle = .full
        return formatter.string(from: savedSeconds) ?? ""
    }
    
    var savedMoney: String {
        let secondsRate = Double(hourlyRate) / 60 / 60
        let savings = savedSeconds * secondsRate
        return savings.formatted(.currency(code: "USD"))
    }
    
    var body: some View {
        VStack {
            Form {
                Picker("Your device", selection: $currentDevice) {
                    ForEach(Device.devices) { device in
                        Text(device.name)
                            .tag(device)
                    }
                }
                
                Picker("Target device", selection: $targetDevice) {
                    ForEach(Device.devices) { device in
                        Text(device.name)
                            .tag(device)
                    }
                }
                
                TextField("Hourly rate", value: $hourlyRate, format: .number)
            }
            
            List(builds) { build in
                if build.title.starts(with: "Build") {
                    Label("\(build.title) on \(build.dateStarted.formatted(date: .abbreviated, time: .shortened)) took \(build.timeTaken) seconds", systemImage: "hammer.circle.fill")
                        .symbolRenderingMode(.hierarchical)
                } else {
                    Label("\(build.title) on \(build.dateStarted.formatted(date: .abbreviated, time: .shortened)) took \(build.timeTaken) seconds", systemImage: "paintbrush")
                        .symbolRenderingMode(.hierarchical)
                        .foregroundStyle(.secondary)
                }
            }
            
            Text("You would have saved \(savedTime) and **\(savedMoney)** by upgrading to a \(targetDevice.name).")
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding(.vertical)
        }
        .padding()
        .onAppear {
            watcher.modelContext = modelContext
        }
    }
}

#Preview {
    ContentView()
}
