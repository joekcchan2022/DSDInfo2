//
//  VehicleReservationReport.swift
//  DSDInfo
//
//  Created by Joe Chan on 10/12/2025.
//

import Foundation

struct VehicleReservationReport: Codable, Identifiable, Hashable {
    var id: Int
    var vrsCode: String
    var vrsName: String
    var groupCode: String
    var groupName: String
    var webUrl: String
    var fileUrl: String
    var orderNo: Int
    var status: String

    private enum CodingKeys: String, CodingKey {
        case id
        case vrsCode = "vrs_code"
        case vrsName = "vrs_name"
        case groupCode = "group_code"
        case groupName = "group_name"
        case webUrl = "web_url"
        case fileUrl = "file_url"
        case orderNo = "order_no"
        case status
    }
    
    // Custom initializer
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        vrsCode = try container.decodeIfPresent(String.self, forKey: .vrsCode) ?? ""
        vrsName = try container.decodeIfPresent(String.self, forKey: .vrsName) ?? ""
        groupCode = try container.decodeIfPresent(String.self, forKey: .groupCode) ?? ""
        groupName = try container.decodeIfPresent(String.self, forKey: .groupName) ?? ""
        webUrl = try container.decodeIfPresent(String.self, forKey: .webUrl) ?? ""
        fileUrl = try container.decodeIfPresent(String.self, forKey: .fileUrl) ?? ""
        orderNo = try container.decode(Int.self, forKey: .orderNo)
        status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
    }
    
    // Default initializer
    init(id: Int, vrsCode: String, vrsName: String, groupCode: String, groupName: String,webUrl: String, fileUrl: String, orderNo: Int, status: String) {
        self.id = id
        self.vrsCode = vrsCode
        self.vrsName = vrsName
        self.groupCode = groupCode
        self.groupName = groupName
        self.webUrl = webUrl
        self.fileUrl = fileUrl
        self.orderNo = orderNo
        self.status = status
    }
}

extension VehicleReservationReport: Displayable {
    var displayCode: String {
        return vrsCode
    }
    
    var displayName: String {
        return vrsName
    }

    var displayNameChinese: String {
        return ""
    }

    var displayGroupCode: String {
        return groupCode
    }

    var displayGroupName: String {
        return groupName
    }

    var displayGroupChinese: String {
        return ""
    }

    var displayOrderNo: Int {
        return orderNo
    }

    var displayUrl: String {
        return fileUrl
    }
}
