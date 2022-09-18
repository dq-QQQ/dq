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
    @FetchRequest( sortDescriptors: [] ) var list: FetchedResults<InterestedList>
    @Environment(\.managedObjectContext) var moc
    @State var bootcampList: [BootcampModel] = []
    @EnvironmentObject var userNotificationViewModel: UserNotificationViewModel
    
    var body: some View {
        if #available(iOS 15.0, *) {
            content
                .task { bootcampList = await bootcampViewModel.fetchFireStore()}
        } else {
            content
                .onAppear() { Task { _ = await bootcampViewModel.fetchFireStore() } }
        }
    }
}

extension TabViews {
    private var content: some View {
        TabView(selection: $viewModel.currentTab) {
            home
            bootcamp
            club
        }
        .accentColor(.dqGreen) // soon deprecated. change to tint.
        .edgesIgnoringSafeArea(.top)
    }
    
    private var home: some View {
        HomeView(bootcampViewModel: bootcampViewModel,
                 clubViewModel: clubViewModel)
        .task {
            bootcampList = await bootcampViewModel.fetchFireStore()
            for i in 0..<list.count {
                for j in 0..<bootcampList.count {
                    if list[i].elementID == bootcampList[j].id {
                        if list[i].expireDate != bootcampList[j].applyDeadline.toDateString(flag: 1) {
                            list[i].expireDate = bootcampList[j].applyDeadline.toDateString(flag: 1)
                            try? moc.save()
                            userNotificationViewModel.resetNotification(id: bootcampList[j].id,
                                                                        name: bootcampList[j].name, expireDate: bootcampList[j].applyDeadline.toDateString(flag: 1), flag: 0)
                        }
                    }
                }
            }
            
            
        }
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
