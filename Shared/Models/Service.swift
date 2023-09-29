//
//  Service.swift
//  DSDInfo2
//
//  Created by Joe Chan on 15/9/2022.
//

import Foundation

enum Tab: Int, Codable {
    case dsdinfo2
    case event
    case orgchart
    case vrs
}

struct Service: Hashable, Codable, Identifiable {
    public var id : Int
    var title     : String
    var cid       : Int
    var category  : String
    var shortName : String
    var name      : String
    var path      : String
    
    func getCidCategory() -> String {
        return String(String(cid) + category)
    }

}

