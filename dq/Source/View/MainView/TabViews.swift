//
//  TabViews.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/29.
//

import SwiftUI

struct TabViews: View {
    @EnvironmentObject var viewModel: ViewModel
    @FetchRequest( sortDescriptors: [] ) var list: FetchedResults<InterestedList>
    @Environment(\.managedObjectContext) var moc
    @State var bootcampList: [BootcampModel] = []
    @EnvironmentObject var userNotificationViewModel: UserNotificationViewModel
    @ObservedObject var mainViewHandler: MainViewHandler
    var fbBootcamp = FirebaseBootcamp("BootCamp")
    var fbClub = FirebaseClub("Club")
    
    
    var body: some View {
        if #available(iOS 15.0, *) {
            content
                .task { bootcampList = await fbBootcamp.fetchFireStore()}
        } else {
            content
                .onAppear() { Task { _ = await fbBootcamp.fetchFireStore() } }
        }
    }
}

extension TabViews {
    private var content: some View {
        TabView(selection: $viewModel.currentTab) {
            home
            bootcamp
            club
//            description
        }
        .accentColor(.dqGreen) // soon deprecated. change to tint.
        .edgesIgnoringSafeArea(.top)
    }
    func setChangeValue() async {
        bootcampList = await fbBootcamp.fetchFireStore()
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
    
    private var home: some View {
        HomeView(fbBootcamp: fbBootcamp,
                 fbClub: fbClub, ho: mainViewHandler)
        .task {
            await setChangeValue()
        }
        .tag(Tabs.home)
        .tabItem(image: "homekit", text: "홈")
    }
    
    private var bootcamp: some View {
        BootcampView(fbBootcamp: fbBootcamp)
            .tag(Tabs.bootcamp)
            .tabItem(image: "laptopcomputer", text: "부트캠프")
    }
    
    private var club: some View {
        ClubView()
            .tag(Tabs.club)
            .tabItem(image: "person.3.sequence", text: "동아리")
    }
    
//    private var description: some View {
//        DescriptionView()
//            .tag(Tabs.description)
//            .tabItem(image: "book", text: "분야별 소개")
//    }
}



//struct TabViews_Previews: PreviewProvider {
//    static var previews: some View {
//        TabViews()
//    }
//}
