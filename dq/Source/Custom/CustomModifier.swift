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
    var flag: Int
    var logoSize: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(width: flag == 0 ? logoSize : logoSize * 2, height: logoSize)
            .foregroundColor(.dqGreen)
            .background(
                Rectangle()
                    .fill(Color.dqWhite)
                    .cornerRadius(10)
            )
    }
}
