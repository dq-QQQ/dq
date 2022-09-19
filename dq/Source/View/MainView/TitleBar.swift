//
//  TitleBar.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/29.
//

import SwiftUI

struct TitleBar: View {
//    @ObservedObject var mainViewHandler: MainViewHandler
    var proxy: GeometryProxy
    
    var body: some View {
        HStack {
            logo
            Spacer()
            EmptyView()
        }
        .padding(.horizontal, proxy.size.width / 15)
    }
}

private extension TitleBar {
    private var logo: some View {
        Text("dq")
            .font(.dqLogoFont)
            .foregroundColor(.dqGreen)
    }
}
//
//struct TitleBar_Previews: PreviewProvider {
//    static var previews: some View {
//        GeometryReader { proxy in
//            TitleBar(mainViewHandler: MainViewHandler(), proxy: proxy)
//        }
//    }
//}
