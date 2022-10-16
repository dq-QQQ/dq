//
//  FirstPageView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/10/16.
//

import SwiftUI

struct FirstPageView: View {
    var body: some View {
        VStack {
            LottieView(filename: "Hello")
                .frame(height: 200)
            Group {
                Text("Do you want to be a")
                    .padding(.bottom)
                    .font(.dqBigFont)
                Text("Developer?")
                    .font(.dqBigBigFont)
            }
            .foregroundColor(.dqWhite)
            LottieView(filename: "Macbook")
                .overlay {
                    LottieView(filename: "SwiftLogo", loop: true)
                        .frame(width: 80, height: 80)
                        .offset(x: 130, y: 75)
                }
                .frame(height: 350)
        }
    }
}

struct FirstPageView_Previews: PreviewProvider {
    static var previews: some View {
        FirstPageView()
    }
}
