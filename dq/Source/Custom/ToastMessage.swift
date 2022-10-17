//
//  ToastMessage.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/10/10.
//

import SwiftUI

struct ToastMessage: View {
    let flag: Bool
    
    var body: some View {
        HStack {
            if flag == true {
                Text(LocalizedStringKey("관심목록에 추가되었어요!"))
                    .font(.headline)
            } else {
                Text(LocalizedStringKey("관심목록에서 삭제되었어요!"))
                    .font(.headline)
            }
            LottieView(filename: "Check", speed: 2)
                .frame(width: 40, height: 40)
                .padding(.trailing, 5)
        }
        .padding(.horizontal, 10)
        .foregroundColor(.dqGreen)
    }
}

struct ToastView: View {
    @Binding var showToast: Bool
    let flag: Bool
    
    var body: some View {
        VStack {
            ToastMessage(flag: flag)
                .background(Color.dqWhite.opacity(0.3))
                .background(.ultraThinMaterial)
                .cornerRadius(15)
            Spacer()
        }
        .padding(.vertical, 20)
        .transition(.move(edge: .top))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.showToast = false
                }
            }
        }
        .onTapGesture {
            withAnimation {
                self.showToast = false
            }
        }
    }
}

