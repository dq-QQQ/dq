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
                Image(systemName: "plus.circle")
                    .padding(.trailing, 5)
                Text(LocalizedStringKey("관심목록에 추가되었어요!"))
                    .font(.headline)
            } else {
                Image(systemName: "minus.circle")
                    .padding(.trailing, 5)
                Text(LocalizedStringKey("관심목록에서 삭제되었어요!"))
                    .font(.headline)
            }
            
            Spacer()
        }
        .foregroundColor(.dqGreen)
        .padding(10)
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
        .padding(.horizontal, 30)
        .opacity(self.showToast ? 0.9 : 0)
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

