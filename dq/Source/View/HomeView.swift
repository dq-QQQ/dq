//
//  HomeView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/15.
//

import SwiftUI

struct HomeView: View {
    @State private var showModal = false
    
    var body: some View {
        ScrollView {
        VStack(alignment: .leading) {
            HStack {
                Text("관심 있어요!")
                Spacer()
                Image(systemName: "arrow.right")
            }
            .font(.dqBigSmallFont)
            .modifier(PaddingFromSide())
            Spacer()
            Text("ho")
                .font(.dqVeryBigFont)
            Text("ho")
                .font(.dqVeryBigFont)
            Text("ho")
                .font(.dqVeryBigFont)
            Text("ho")
                .font(.dqVeryBigFont)

        }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
