//
//  DSDInfo2View.swift
//  DSDInfo2 (iOS)
//
//  Created by Joe Chan on 19/9/2022.
//

import SwiftUI
    
struct DSDInfo2View: View {
    @EnvironmentObject var serviceData : ServiceData
    @Binding var tabSelection : Tab

    @State var textHeight: CGFloat = 30 // <-- this
    @State var goWhenTrue: Bool = false

    var body: some View {
        NavigationView() {
            List {
                VStack {
                    Text("DSDInfo2 provides the mobile version of the following:")
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color(UIColor.systemGray))
                        .font(.callout)
                        .lineLimit(5)
                    Spacer(minLength: textHeight)
                }
                VStack {
                    Button {
                        print("Event")
                        tabSelection = Tab.event
                    } label: {
                        HStack {
                            Image(systemName: "calendar.circle.fill")
                                .font(.title)
                            Text("Event")
                                .font(.title2)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(UIColor.systemBlue))
                        .clipShape(Capsule())
                        .foregroundColor(Color(UIColor.white))
                    }
                    Text("Engineer Talks, Staff Club Activity and Other Events")
                        .font(.callout)
                        .lineLimit(5)
                    Spacer(minLength: textHeight)
                }
                VStack {
                    Button {
                        print("Organization Chart")
                        tabSelection = Tab.orgchart
                    } label: {
                        HStack {
                            Image(systemName: "circle.hexagongrid.circle.fill")
                                .font(.title)
                            Text("Organization Chart")
                                .font(.title2)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(UIColor.systemBlue))
                        .clipShape(Capsule())
                        .foregroundColor(Color(UIColor.white))
                    }
                    Text("Organization Charts")
                        .font(.callout)
                        .lineLimit(5)
                    Spacer(minLength: textHeight)
                }
                VStack {
                    Button {
                        print("Vehicle Reservation")
                        tabSelection = Tab.vrs
                    } label: {
                        HStack {
                            Image(systemName: "car.circle.fill")
                                .font(.title)
                            Text("Vehicle Reservation")
                                .font(.title2)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(UIColor.systemBlue))
                        .clipShape(Capsule())
                        .foregroundColor(Color(UIColor.white))
                    }
                    Text("Vehicle Booking and Driver Information")
                        .font(.callout)
                        .lineLimit(5)
                    Spacer(minLength: textHeight)
                }
                VStack {
                    NavigationLink("About",
                                    destination: AboutView(),
                                    isActive: $goWhenTrue)
                }
            }
            .onPreferenceChange(ContentLengthPreference.self) { value in // <-- this
              DispatchQueue.main.async {
                 self.textHeight = value
              }
            }
            //        .listStyle(InsetGroupedListStyle())
            .navigationTitle("DSDInfo2")
            .navigationBarTitleDisplayMode(.automatic)
//            .navigationBarBackButtonHidden(false)
            /* Return Button on Toolbar */
            .toolbar() {
                //
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
