//
//  HomeView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/15.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            ElementsOnTop()
            Text("안녕 이건 마비노기 폰트야 부트캠프")
                .font(.dqBigFont)
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
