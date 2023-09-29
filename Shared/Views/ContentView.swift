//
//  ContentView.swift
//  DSDInfo2
//
//  Created by Joe Chan on 14/9/2022.
//

import SwiftUI
import PDFKit

struct ContentView: View {
    @EnvironmentObject var serviceData : ServiceData
    
    @State var tabSelection  : Tab = Tab.dsdinfo2

    var body: some View {
        TabView(selection: $tabSelection) {
            DSDInfo2View(tabSelection: $tabSelection)
                .tabItem {
                    Image(systemName: "star.circle.fill")
                        .foregroundColor(Color(UIColor.systemFill))
                    Text("DSDInfo2")}
                .tag(Tab.dsdinfo2)
            ServiceList(selectedTitle: "Event", selectedServices: serviceData.filterServices(selectedTitle: "Event"))
                .tabItem {
                    Image(systemName: "calendar.circle.fill")
                        .foregroundColor(Color(.systemYellow))
                    Text("Event")}
                .tag(Tab.event)
            ServiceList(selectedTitle: "Organization Chart", selectedServices: serviceData.filterServices(selectedTitle: "Organization Chart"))
                .tabItem {
                    Image(systemName: "circle.hexagongrid.circle.fill")
                        .foregroundColor(Color(.systemYellow))
                    Text("Organization Chart")}
                .tag(Tab.orgchart)
            ServiceList(selectedTitle: "Vehicle Reservation", selectedServices: serviceData.filterServices(selectedTitle: "Vehicle Reservation"))
                .tabItem {
                    Image(systemName: "car.circle.fill")
                        .foregroundColor(Color(.systemYellow))
                    Text("Vehicle Reservation")}
                .tag(Tab.vrs)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
    }
}

