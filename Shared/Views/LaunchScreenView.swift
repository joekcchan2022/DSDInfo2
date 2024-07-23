//
//  LaunchScreenView.swift
//  DSDInfo2 (iOS)
//
//  Created by Joe Chan on 23/7/2024.
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
                Image(colorScheme == .light ? "DSDInfo2 Light" : colorScheme == .dark ? "DSDInfo2 Dark" : "DSDInfo2 Tinted")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200, alignment: .leading)
                Divider()
                    .hidden()
                Text("DSDInfo2")
                    .font(.largeTitle)
                    .lineLimit(1)
                    .foregroundColor(.primary)
            }
            Spacer()
            Spacer()
            Spacer()
            Group {
                Text("Drainage Services Department")
                    .font(.body)
                    .lineLimit(1)
                    .foregroundColor(Color.white)
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
                    .foregroundColor(Color(UIColor.systemGray))
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



