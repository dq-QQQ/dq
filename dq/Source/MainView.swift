//
//  ContentView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/15.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewRouter = ViewRouter()
    var body: some View {
        GeometryReader { proxy in
            if viewRouter.currentPage == SwitchView.main.rawValue {
                VStack {
                    TitleSubView(viewRouter: viewRouter, proxy: proxy)
                    TabView(selection: $viewRouter.currentTab) {
                        home
                        bootcamp
                        club
                    }
                    .accentColor(.dqGreen) // soon deprecated. change to tint.
                    .edgesIgnoringSafeArea(.top)
                }
            }
            else if viewRouter.currentPage == SwitchView.info.rawValue {
                InfoView(viewRouter: viewRouter)
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
    @ObservedObject var viewRouter: ViewRouter
    var proxy: GeometryProxy
    
    var body: some View {
        HStack {
            logo
            Spacer()
            goToInfo
        }
        .padding(.horizontal, proxy.size.width / 20)
    }
    
}

// **********Extension**********
extension MainView {
    private var home: some View {
        HomeView()
            .tabItem(image: "homekit", text: "홈")
    }
    
    private var bootcamp: some View {
        BootcampView()
            .tabItem(image: "laptopcomputer", text: "부트캠프")
    }
    
    private var club: some View {
        ClubView()
            .tabItem(image: "person.3.sequence", text: "동아리")
    }
}

extension TitleSubView {
    private var logo: some View {
        Text("dq")
            .font(.dqLogoFont)
            .foregroundColor(.dqGreen)
            .padding()
    }
    
    private var goToInfo: some View {
        Button {
            viewRouter.currentPage = SwitchView.info.rawValue
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
    }
}
