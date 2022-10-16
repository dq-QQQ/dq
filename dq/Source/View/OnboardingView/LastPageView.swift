//
//  LastPageView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/10/11.
//

import SwiftUI

struct OnboardingLastPageView: View {
    @Binding var isFirstLaunching: Bool
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                Text("dq")
                    .font(.dqBigLogoFont)
                    .foregroundColor(.dqWhite)
                Text("에서 알아보세요!")
                    .font(.dqBigFont)
                    .foregroundColor(.dqWhite)
            }
            
            HStack {
                Spacer()
                Button {
                    isFirstLaunching.toggle()
                } label: {
                    HStack {
                        Text("시작하기")
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.dqGreen)
                    .frame(width: 200, height: 50)
                    .background(Color.dqWhite)
                    .cornerRadius(6)
                }
                .padding()
            }
        }
    }
}
