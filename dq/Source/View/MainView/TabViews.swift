//
//  TabViews.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/29.
//

import SwiftUI

struct TabViews: View {
    @EnvironmentObject var viewModel: ViewModel
    @ObservedObject private var bootcampViewModel = BootcampViewModel("BootCamp")
    @ObservedObject private var clubViewModel = ClubViewModel("Club")
    
    var body: some View {
        TabView(selection: $viewModel.currentTab) {
//            Group {
                home
                bootcamp
                club
//            }
        }
        .task { _ = await bootcampViewModel.fetchFireStore() }
        .accentColor(.dqGreen) // soon deprecated. change to tint.
        .edgesIgnoringSafeArea(.top)
    }
}

extension TabViews {
    private var home: some View {
        HomeView(bootcampViewModel: bootcampViewModel,
                 clubViewModel: clubViewModel)
            .tag(Tabs.home)
            .tabItem(image: "homekit", text: "홈")
    }
    
    private var bootcamp: some View {
        BootcampView(bootcampViewModel: bootcampViewModel)
            .tag(Tabs.bootcamp)
            .tabItem(image: "laptopcomputer", text: "부트캠프")
    }
    
    private var club: some View {
        ClubView()
            .tag(Tabs.club)
            .tabItem(image: "person.3.sequence", text: "동아리")
    }
    
    
}

struct TabViews_Previews: PreviewProvider {
    static var previews: some View {
        TabViews()
    }
}
