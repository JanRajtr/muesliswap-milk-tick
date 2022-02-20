//
//  AppSettings.swift
//  MuesliSwapTick
//
//  Created by Jan Rajtr on 20.02.2022.
//

import Foundation
import SwiftUI

enum AppSettingsKeys: String {
    case favouritePairs
    
}
/*
class AppSettings: ObservedObject {
    //@AppStorage(AppSettingsKeys.pairs.rawValue) var pairs: [String] = []
}
*/

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
