//
//  UIDevice+ModelName.swift
//  DSDInfo
//
//  Created by Joe Chan on 17/12/2025.
//

import Foundation
import UIKit

extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        // Load device types from JSON
        let deviceTypes = loadDeviceTypes()
        
        // Return the mapped name or identifier
        return deviceTypes[identifier] ?? identifier
    }

    private func loadDeviceTypes() -> [String: String] {
        guard let url = Bundle.main.url(forResource: "device_types", withExtension: "json") else {
            return [:]
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([String: String].self, from: data)
            return decoded
        } catch {
            print("Error loading device types: \(error)")
            return [:]
        }
    }
}
