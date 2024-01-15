//
//  BuildWatcher.swift
//  UpgradeYourMac
//
//  Created by Kuba Milcarz on 1/14/24.
//

import Foundation
import SwiftData

class BuildWatcher {
    struct DirectoryChange: Hashable {
        var url: URL
        var date: Date
    }
    
    let url = URL.libraryDirectory.appending(path: "Developer/Xcode/DerivedData")
    
    var contents = Set<DirectoryChange>()
    var timer = Timer()
    
    var modelContext: ModelContext?
    
    
    init() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            try? self?.performScan()
        })
        
        self.timer.tolerance = 1
        
        do {
            try performScan(firstRun: true)
        } catch {
            fatalError("Failed to scan directory.")
        }
    }
    
    
    func performScan(firstRun: Bool = false) throws {        
        let urls = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: [.contentModificationDateKey])
        
        var newURLs = Set<DirectoryChange>()
        
        for url in urls {
            let pathToManifest = url.appending(path: "Logs/Build/LogStoreManifest.plist")
            
            if FileManager.default.fileExists(atPath: pathToManifest.path()) {
                let result = try pathToManifest.resourceValues(forKeys: [.contentModificationDateKey])
                
                if let date = result.contentModificationDate {
                    newURLs.insert(DirectoryChange(url: pathToManifest, date: date))
                }
            }
        }
        
        if firstRun == false {
            handleChanges(from: newURLs)
        }
        
        contents = newURLs
    }
    
    
    func handleChanges(from newDirectories: Set<DirectoryChange>) {
        let changedDirectories = newDirectories.subtracting(contents)
        
        for changedDirectory in changedDirectories {
            if let data = try? Data(contentsOf: changedDirectory.url) {
                let decoder = PropertyListDecoder()
                
                if let decoded = try? decoder.decode(BuildManifest.self, from: data) {
                    if let log = decoded.logs.values.max() {
                        modelContext?.insert(log)
                    }
                } else {
                    print("Decoding failed.")
                }
            }
        }
    }
}
