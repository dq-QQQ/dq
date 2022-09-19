//
//  customModifier.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/18.
//

import Foundation
import SwiftUI

struct PaddingFromSideOnHomeView: ViewModifier {
    @EnvironmentObject private var viewModel: ViewModel
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, viewModel.getPhoneSize().width / 20)
    }
}

struct TextStyleInModalView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical)
            .foregroundColor(.dqGreen)
            .font(.dqMediumBigFont)
    }
}

struct ToolbarStyleInModalView: ViewModifier {
    var logoSize: CGFloat
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.dqRed)
            .frame(width: logoSize, height: logoSize)
//            .background(
//                Rectangle()
//                    .fill(Color.dqWhite)
//                    .cornerRadius(10)
//            )
    }
}

