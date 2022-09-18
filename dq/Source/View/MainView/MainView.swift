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
    @FetchRequest( sortDescriptors: [] ) var list: FetchedResults<InterestedList>
    @EnvironmentObject private var userNotificationViewModel: UserNotificationViewModel
    
    
    var body: some View {
        GeometryReader { proxy in
            switch mainViewHandler.currentPage {
            case SwitchView.main.rawValue : main(proxy)
            case SwitchView.info.rawValue : info
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
            TabViews()
        }
        .onAppear { viewModel.setGeoProxy(proxy) }
    }
    
    private var info: some View {
        InfoView(mainViewHandler: mainViewHandler)
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ViewModel())
    }
}
