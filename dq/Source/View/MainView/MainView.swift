//
//  ContentView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/15.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: ViewModel
    @ObservedObject var mainViewHandler = MainViewHandler()
    @EnvironmentObject private var userNotificationViewModel: UserNotificationViewModel
    
    var body: some View {
        GeometryReader { proxy in
            switch mainViewHandler.currentPage {
            case SwitchView.main.rawValue : main(proxy)
            case SwitchView.info.rawValue : ho(ho: mainViewHandler)
            case SwitchView.admin.rawValue: InfoView(mainViewHandler: mainViewHandler)
            default                       : main(proxy)
            }
        }
        .onAppear {
            userNotificationViewModel.getAuthorization()
        }
    }
}

private extension MainView {
    private func main(_ proxy: GeometryProxy) -> some View {
        VStack {
            TitleBar(mainViewHandler: mainViewHandler, proxy: proxy)
            TabViews(mainViewHandler: mainViewHandler)
        }
        .onAppear { viewModel.setGeoProxy(proxy) }
    }

    private var info: some View {
        InfoView(mainViewHandler: mainViewHandler)
    }
}

struct InfoView: View {
    var mainViewHandler: MainViewHandler
    
    var body: some View {
        Button {
            mainViewHandler.currentPage = SwitchView.main.rawValue
        } label: {
            Text("admin page")
        }
    }
}

struct ho: View {
    @ObservedObject var ho: MainViewHandler
    var body: some View {
        Button {
            ho.currentPage = SwitchView.main.rawValue
        } label: {
            Text("ho")
                .font(.dqBigFont)
        }

    }
}
//
//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//            .environmentObject(ViewModel())
//    }
//}
