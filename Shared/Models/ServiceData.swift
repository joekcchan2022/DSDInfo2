//
//  ServiceData.swift
//  DSDInfo2
//
//  Created by Joe Chan on 15/9/2022.
//

import Foundation

final class ServiceData: ObservableObject {
    @Published
    var services        : [Service] = LoadData("DSDInfo")
    
    var categories      : [String: [Service]] {
        Dictionary(
            grouping: services.filter { $0.title == "Organization Chart" },
            by: { $0.category }
        )
    }
    
    var cidCategories   : [String: [Service]] {
        Dictionary(
            grouping: services.filter { $0.title == "Organization Chart" },
            by: { $0.getCidCategory() }
        )
    }

    
    func filterServices(selectedTitle: String) -> [Service] {
        return services.filter { $0.title == selectedTitle }
    }

    func filterCategories(selectedTitle: String) -> [String: [Service]] {
        Dictionary(
            grouping: services.filter { $0.title == selectedTitle },
            by: { $0.category }
        )
    }

    func filterCidCategories(selectedTitle: String) -> [String: [Service]] {
        Dictionary(
            grouping: services.filter { $0.title == selectedTitle },
            by: { $0.getCidCategory() }
        )
    }
    
}

