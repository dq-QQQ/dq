//
//  TitleBar.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/29.
//

import SwiftUI
import Firebase

struct TitleBar: View {
    // Use: Switch mainView to AdminView
    @ObservedObject var mainViewHandler: MainViewHandler
    // Use: get admin UUID from realtimeFirebase
    @ObservedObject var realtimeFirebase: RealtimeFirebase
    // Use: Compare with adminUUID
    let deviceUUID = UIDevice.current.identifierForVendor!.uuidString
    // Use: Get phone size
    var proxy: GeometryProxy

    var body: some View {
        HStack {
            logo
            Spacer()
            if realtimeFirebase.getAdminUUID() == deviceUUID {
                goToInfo
            } else {
                EmptyView()
            }
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
    
    private var goToInfo: some View {
        let logoSize = proxy.size.width / 12
        return Button {
            mainViewHandler.currentPage = SwitchView.admin.rawValue
        } label: {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: logoSize, height: logoSize)
                .foregroundColor(.dqGray)
        }
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
