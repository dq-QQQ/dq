//
//  AdminView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/09/20.
//

import SwiftUI

struct AdminView: View {
    var mainViewHandler: MainViewHandler
    
    var body: some View {
        Button {
            mainViewHandler.currentPage = SwitchView.main.rawValue
        } label: {
            Text("admin page")
        }
    }
}

//struct AdminView_Previews: PreviewProvider {
//    static var previews: some View {
//        AdminView()
//    }
//}
