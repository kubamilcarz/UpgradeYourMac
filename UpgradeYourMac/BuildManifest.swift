//
//  BuildManifest.swift
//  UpgradeYourMac
//
//  Created by Kuba Milcarz on 1/14/24.
//

import Foundation
import SwiftData

struct BuildManifest: Codable {
    var logs: [String: BuildLog]
}

@Model
class BuildLog: Codable {
    enum CodingKeys: String, CodingKey {
        case title, timeStartedRecording, timeStoppedRecording
    }
    
    var title: String
    var timeStartedRecording: Double
    var timeStoppedRecording: Double
    
    var timeTaken: Double {
        timeStoppedRecording - timeStartedRecording
    }
    
    var dateStarted: Date {
        Date(timeIntervalSinceReferenceDate: timeStartedRecording)
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.timeStartedRecording = try container.decode(Double.self, forKey: .timeStartedRecording)
        self.timeStoppedRecording = try container.decode(Double.self, forKey: .timeStoppedRecording)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.timeStartedRecording, forKey: .timeStartedRecording)
        try container.encode(self.timeStoppedRecording, forKey: .timeStoppedRecording)
    }
}
