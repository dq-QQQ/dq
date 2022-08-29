//
//  InfoView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/17.
//

import SwiftUI

struct InfoView: View {
    var mainViewHandler: MainViewHandler
    var body: some View {
        Button {
            mainViewHandler.currentPage = SwitchView.main.rawValue
        } label: {
            Text("ho")
                .font(.largeTitle)
        }

    }
}
//
//struct InfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        InfoView(viewHandler: ViewHandler())
//    }
//}
