//
//  ContentView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/15.
//

import SwiftUI

struct MainView: View {
    // Use: Settinng the proxy
    @EnvironmentObject var viewModel: ViewModel
    // Use: Showing the View according to currentPage Value
    @ObservedObject var mainViewHandler = MainViewHandler()
    // Use: getting authorization
    @EnvironmentObject private var userNotificationViewModel: UserNotificationViewModel
    
    @ObservedObject var realtimeFirebase = RealtimeFirebase()
    
    @EnvironmentObject var toastViewModel: ToastViewModel
    
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    
    var body: some View {
        GeometryReader { proxy in
            switch mainViewHandler.currentPage {
            case SwitchView.main.rawValue : main(proxy)
            case SwitchView.admin.rawValue: AdminView(mainViewHandler: mainViewHandler)
            default                       : main(proxy)
            }
        }
        .fullScreenCover(isPresented: $isFirstLaunching) {
            OnboardingView(isFirstLaunching: $isFirstLaunching)
        }
        .onAppear {
            userNotificationViewModel.getAuthorization()
        }
        .showToast(showToast: $toastViewModel.showTopToast, content:
                    ToastView(showToast: $toastViewModel.showTopToast,
                              flag: toastViewModel.flag))
    }
}

private extension MainView {
    private func main(_ proxy: GeometryProxy) -> some View {
        VStack {
            TitleBar(mainViewHandler: mainViewHandler, realtimeFirebase: realtimeFirebase, proxy: proxy)
            TabViews(mainViewHandler: mainViewHandler, isFirstLaunching: $isFirstLaunching)
        }
        .onAppear {
            viewModel.setGeoProxy(proxy)
            realtimeFirebase.setAdminUUID()
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
