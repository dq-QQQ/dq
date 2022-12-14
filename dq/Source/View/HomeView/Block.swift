//
//  Block.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/29.
//

import SwiftUI

struct Block: View {
    var title: String
    var flag: Int
    var fbBootcamp: FirebaseBootcamp
    @EnvironmentObject private var viewModel: ViewModel
    
    var body: some View {
        titleOfBlock(title)
        
            ZStack {
                blockRectangle
                ListInBlock(flag: flag, fbBootcamp: fbBootcamp)
            }
            .modifier(PaddingFromSideOnHomeView())
        
    }
}

private extension Block {
    var phoneWidth: CGFloat { viewModel.getPhoneSize().width }
    var phoneHeight: CGFloat { viewModel.getPhoneSize().height  }
    var logoSize: CGFloat { phoneWidth / 4 }
    
    func titleOfBlock(_ a: String) -> some View {
        Text(a)
            .modifier(PaddingFromSideOnHomeView())
            .frame(width: phoneWidth, alignment: .leading)
            .font(.dqBigSmallFont)
    }
    
    var blockRectangle: some View {
        ZStack() {
            Rectangle()
                .frame(height: phoneHeight / 3.7 + 20)
                .foregroundColor(.dqVanilla)
            VStack {
                Circle()
                    .foregroundColor(.dqGreen)
                    .overlay {
                        Text("x")
                            .font(.dqSmallFont)
                            .foregroundColor(.dqWhite)
                            .padding(.top, 1)
                    }
                    .padding(.top, 10)
                Rectangle()
                    .frame(height: phoneHeight / 3.7)
                    .foregroundColor(.dqWhite)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.black.opacity(0.5), radius: 8, x: 0, y: 6)
        
    }
}
//
//struct Block_Previews: PreviewProvider {
//    static var previews: some View {
//        Block(title: "관심있어요!", flag: 0, fbBootcamp: fbBootcamp("bootcamp"))
//    }
//}
