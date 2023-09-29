//
//  ServiceRow.swift
//  DSDInfo2
//
//  Created by Joe Chan on 15/9/2022.
//

import SwiftUI

struct ServiceRow: View {
    @State var textHeight: CGFloat = 30 // <-- this
    @State var checked = false

    var service: Service

    var body: some View {
        HStack {
            RoundedRectangle(cornerSize: CGSize(width: 5, height: 5))
                .fill(Color(UIColor.systemFill))
                .frame(width: 70, height: 40)
                .overlay(Text(service.shortName)
                    .font(.title2)
                    .scaledToFill()
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                )
            HStack {
                VStack {
                    Text(service.name)
                        .lineLimit(2)
                }
            }
        }
        .onPreferenceChange(ContentLengthPreference.self) { value in // <-- this
          DispatchQueue.main.async {
             self.textHeight = value
          }
        }
    }
}



struct ServiceRow_Previews: PreviewProvider {
    static var serviceData = ServiceData()

    static var previews: some View {
        Group {
            ServiceRow(service: serviceData.services[0])
            ServiceRow(service: serviceData.services[1])
            ServiceRow(service: serviceData.services[2])
        }
        .previewLayout(.fixed(width: 500, height: 200))
    }
}
