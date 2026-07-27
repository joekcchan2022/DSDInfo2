//
//  OrganizationChart.swift
//  DSDInfo
//
//  Created by Joe Chan on 10/12/2025.
//

import Foundation

struct OrganizationChart: Codable, Identifiable, Hashable {
    var id: Int
    var name: String
    var shortName: String
    var orgCode: String
    var orgName: String
    var orgChinese: String
    var branchCode: String
    var branchName: String
    var branchChinese: String
    var orderNo: Int
    var status: String
    var webUrl: String
    var fileUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case shortName = "short_name"
        case orgCode = "org_code"
        case orgName = "org_name"
        case orgChinese = "org_chinese"
        case branchCode = "branch_code"
        case branchName = "branch_name"
        case branchChinese = "branch_chinese"
        case orderNo = "order_no"
        case status
        case webUrl = "web_url"
        case fileUrl = "file_url"
    }
    
    // Custom initializer
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        shortName = try container.decodeIfPresent(String.self, forKey: .shortName) ?? ""
        orgCode = try container.decodeIfPresent(String.self, forKey: .orgCode) ?? ""
        orgName = try container.decodeIfPresent(String.self, forKey: .orgName) ?? ""
        orgChinese = try container.decodeIfPresent(String.self, forKey: .orgChinese) ?? ""
        branchCode = try container.decodeIfPresent(String.self, forKey: .branchCode) ?? ""
        branchName = try container.decodeIfPresent(String.self, forKey: .branchName) ?? ""
        branchChinese = try container.decodeIfPresent(String.self, forKey: .branchChinese) ?? ""
        orderNo = try container.decode(Int.self, forKey: .orderNo)
        status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        webUrl = try container.decodeIfPresent(String.self, forKey: .webUrl) ?? ""
        fileUrl = try container.decodeIfPresent(String.self, forKey: .fileUrl) ?? ""
    }
    
    // Default initializer
    init(id: Int, name: String, shortName: String, orgCode: String, orgName: String, orgChinese: String, branchCode: String, branchName: String, branchChinese: String, orderNo: Int, status: String, webUrl: String, fileUrl: String) {
        self.id = id
        self.name = name
        self.shortName = shortName
        self.orgCode = orgCode
        self.orgName = orgName
        self.orgChinese = orgChinese
        self.branchCode = branchCode
        self.branchName = branchName
        self.branchChinese = branchChinese
        self.orderNo = orderNo
        self.status = status
        self.webUrl = webUrl
        self.fileUrl = fileUrl
    }
}

extension OrganizationChart: Displayable {
    var displayCode: String {
        return shortName.hasSuffix("_prof") ? "\(orgCode)(P)" : orgCode
    }
    
    var displayName: String {
        return shortName.hasSuffix("_prof") ? "\(orgName) (Professionals)" : orgName
    }

    var displayNameChinese: String {
        return shortName.hasSuffix("_prof") ? "\(orgChinese)(專業人士)" : orgChinese
    }

    var displayGroupCode: String {
        return branchCode
    }

    var displayGroupName: String {
        return branchName
    }

    var displayGroupChinese: String {
        return branchChinese
    }

    var displayOrderNo: Int {
        return orderNo
    }

    var displayUrl: String {
        return fileUrl
    }
}
