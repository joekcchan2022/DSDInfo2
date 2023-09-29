//
//  ServiceList.swift
//  DSDInfo2
//
//  Created by Joe Chan on 16/9/2022.
//

import SwiftUI

struct ServiceList: View {
    @EnvironmentObject var serviceData : ServiceData
    
    var selectedTitle: String
    var selectedServices: [Service]
    
    let apiPrefixURL: String = "https://m.dsd.gov.hk:18447/mdsdinfo/"
                    
    var body: some View {
        if selectedTitle == "Organization Chart" {
            let cidCategoriesList = serviceData.cidCategories.keys.sorted() { $0 < $1 }
            NavigationView {
                List {
                    ForEach(cidCategoriesList, id: \.self) { category in
                        Section(header: Text(category.dropFirst(1)).foregroundColor(Color(UIColor.systemBlue))) {
                            ForEach(selectedServices.filter { $0.category == category.dropFirst(1) }, id: \.id) { service in
                                NavigationLink {
                                    ServiceDetailView(serviceName: service.name, urlPath: (apiPrefixURL + service.path))
                                } label: {
                                    ServiceRow(service: service)
                                }
                            }
                        }
                    }
                }
                .toolbar {
                    //
                }
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitleDisplayMode(.automatic)
                .navigationTitle(selectedTitle)
                .navigationViewStyle(StackNavigationViewStyle())
            }
        } else {
            NavigationView {
                List {
                    Section(header: Text(selectedTitle).foregroundColor(Color(UIColor.systemBlue))) {
                        ForEach(selectedServices, id: \.id) { service in
                            NavigationLink {
                                ServiceDetailView(serviceName: service.name, urlPath: (apiPrefixURL + service.path))
                            } label: {
                                ServiceRow(service: service)
                            }
                        }
                    }
                }
                .toolbar {
                    //
                }
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitleDisplayMode(.automatic)
                .navigationTitle(selectedTitle)
            }
        }
        
    }
}
