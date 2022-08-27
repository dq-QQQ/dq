//
//  ContentView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/15.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewHandler: ViewHandler
    @ObservedObject private var bootcampViewModel = BootcampViewModel("BootCamp")
    @ObservedObject private var clubViewModel = ClubViewModel("Club")
//    private var 
    var body: some View {
        GeometryReader { proxy in
            if viewHandler.currentPage == SwitchView.main.rawValue {
                VStack {
                    TitleSubView(viewHandler: viewHandler, proxy: proxy)
                    TabView(selection: $viewHandler.currentTab) {
                        Group {
                            home
                            bootcamp
                            club
                        }
                        .task {
                            _ = await bootcampViewModel.fetchFireStore()
                        }
                    }
                    .accentColor(.dqGreen) // soon deprecated. change to tint.
                    .edgesIgnoringSafeArea(.top)
                }
                .onAppear {
                    viewHandler.setGeoProxy(proxy)
                }
            }
            else if viewHandler.currentPage == SwitchView.info.rawValue {
                InfoView(viewHandler: viewHandler)
            }
        }
    }
}

fileprivate extension View {
    func tabItem(image: String, text:String) -> some View {
        self.tabItem {
            Image(systemName: image)
            Text(text)
        }
    }
}

// Mark - SubView of MainView, Located in top
struct TitleSubView: View {
    @ObservedObject var viewHandler: ViewHandler
    var proxy: GeometryProxy
    
    var body: some View {
        HStack {
            logo
            Spacer()
            goToInfo
        }
        .padding(.horizontal, proxy.size.width / 15)
    }
    
}

// **********Implement**********
extension MainView {
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

extension TitleSubView {
    private var logo: some View {
        Text("dq")
            .font(.dqLogoFont)
            .foregroundColor(.dqGreen)
        //            .padding()
    }
    
    private var goToInfo: some View {
        Button {
            viewHandler.currentPage = SwitchView.info.rawValue
        } label: {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: proxy.size.width / 10 , height: proxy.size.height / 20)
                .foregroundColor(.dqGray)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ViewHandler())
    }
}
