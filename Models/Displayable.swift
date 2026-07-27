//
//  Displayable.swift
//  DSDInfo
//
//  Created by Joe Chan on 6/1/2026.
//

import Foundation

protocol Displayable: Codable, Identifiable, Hashable {
    var displayCode: String { get }
    var displayName: String { get }
    var displayNameChinese: String { get }
    var displayGroupCode: String { get }
    var displayGroupName: String { get }
    var displayGroupChinese: String { get }
    var displayOrderNo: Int { get }
    var displayUrl: String { get }
}
