//
//  InfoView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/17.
//

import SwiftUI

struct InfoView: View {
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        Button {
            viewRouter.currentPage = SwitchView.main.rawValue
        } label: {
            Text("ho")
                .font(.largeTitle)
        }

    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(viewRouter: ViewRouter())
    }
}
