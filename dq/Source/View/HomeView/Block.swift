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
    @ObservedObject var bootcampViewModel: BootcampViewModel
    @EnvironmentObject private var viewModel: ViewModel
    
    var body: some View {
        titleOfBlock(title)
        ZStack {
            blockRectangle
            ListInBlock(flag: flag, bootcampViewModel: bootcampViewModel)
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
        Rectangle()
            .frame(height: phoneHeight / 4)
            .foregroundColor(.dqWhite)
            .cornerRadius(20)
    }
}

struct Block_Previews: PreviewProvider {
    static var previews: some View {
        Block(title: "관심있어요!", flag: 0, bootcampViewModel: BootcampViewModel("bootcamp"))
    }
}
