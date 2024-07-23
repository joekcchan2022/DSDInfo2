//
//  AboutView.swift
//  DSDInfo2
//
//  Created by Joe Chan on 15/9/2022.
//

import SwiftUI

extension Bundle {

    var shortVersion: String {
        if let result = infoDictionary?["CFBundleShortVersionString"] as? String {
            return result
        } else {
            assert(false)
            return ""
        }
    }

    var buildVersion: String {
        if let result = infoDictionary?["CFBundleVersion"] as? String {
            return result
        } else {
            assert(false)
            return ""
        }
    }

    var minimumOSVersion: String {
        if let result = infoDictionary?["MinimumOSVersion"] as? String {
            return result
        } else {
            assert(false)
            return ""
        }
    }

    var buildDate: Date {

        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let infoPath = Bundle.main.path(forResource: "Info", ofType: "plist"),
            let infoAttr = try? FileManager.default.attributesOfItem(atPath: infoPath),
            let infoDate = infoAttr[.modificationDate] as? Date {
                return infoDate
        }
        return Date()
    }

}


struct AboutView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationView() {
            VStack {
                List {
                    HStack {
                        VStack {
                            Spacer()
                            Image(colorScheme == .light ? "DSDInfo2 Light" : colorScheme == .dark ? "DSDInfo2 Dark" : "DSDInfo2 Tinted")
                                .resizable()
                                .frame(width: 128, height: 128)
                                .cornerRadius(16)
                            Spacer()
                            Text("DSDInfo2")
                                .font(.title2)
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    HStack {
                        VStack {
                            Spacer()
                            Spacer()
                            Text("Version: \(Bundle.main.shortVersion)")
                                .font(.callout)
                            Spacer()
                            Text("Build: \(Bundle.main.buildVersion)")
                                .font(.callout)
                            Spacer()
                            Text("Minimum iOS Version: \(Bundle.main.minimumOSVersion)")
                                .font(.callout)
                            Spacer()
                            if #available(iOS 15.0, *) {
                                Text("Date: \(Bundle.main.buildDate.self.formatted(date: .complete, time: .omitted))")
                                    .font(.callout)
                                Spacer()
                            } else {
                                // Fallback on earlier versions
                            }
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    Text("Designed by ITMU/DSD")
                        .frame(maxWidth: .infinity, alignment: .center)
                    }

                Text("K.C. Chan, Joe, CSSA7/CS @ ITMU")
                    .fontWeight(.ultraLight)
                    .foregroundColor(Color(UIColor.systemGroupedBackground))
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.automatic)
            /* Return Button on Toolbar */
            .toolbar() {
                //
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
        .previewLayout(.fixed(width: 500, height: 800))
    }
}
