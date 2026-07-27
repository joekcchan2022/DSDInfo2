//
//  LaunchScreenView.swift
//  DSDInfo
//
//  Created by Joe Chan on 9/12/2025.
//

import SwiftUI

struct LaunchScreenView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var shouldAnimate = false

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Spacer()
            Group {
                Image(colorScheme == .light ? "DSDInfo Light" : colorScheme == .dark ? "DSDInfo Dark" : "DSDInfo Tinted")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200, alignment: .leading)
                Divider()
                    .hidden()
                Text("DSDInfo")
                    .font(.largeTitle)
                    .bold()
                    .lineLimit(1)
                    .foregroundColor(Color("DSD Blue 100%"))
            }
            Spacer()
            Spacer()
            Spacer()
            Group {
                Text("Drainage Services Department")
                    .font(.body)
                    .lineLimit(1)
                    .foregroundColor(Color(UIColor.systemGroupedBackground))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        Rectangle()
                            .fill(Color("DSD Blue 100%"))
                    )
                Divider()
                    .hidden()
                Text("Established in 1989")
                    .font(.footnote)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                    .padding(.top, 5)
            }
            Spacer()
            VStack {
                Text("K.C. Chan, Joe, CSSA7/CS @ ITMU")
                    .fontWeight(.ultraLight)
                    .foregroundColor(Color(UIColor.systemGroupedBackground))
                    .fixedSize()
                Text("joekcchan@dsd.gov.hk")
                    .fontWeight(.ultraLight)
                    .foregroundColor(Color(UIColor.systemGroupedBackground))
                    .fixedSize()
            }
            .opacity(0)
        }
        .opacity(shouldAnimate ? 1.0 : 0.0)
        .shadow(radius: 10.0)
        .animation(.easeInOut(duration: 0.25).delay(0.5), value: 1.0)
        .onAppear {
            self.shouldAnimate = true
        }
    }
}

#Preview {
    LaunchScreenView()
}
