//
//  ContentView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/15.
//

import SwiftUI

struct MainView: View {
    @State private var currentTab: Tabs = .home
    
    var body: some View {
        TabView(selection: $currentTab) {
            Group {
                home
                bootcamp
                club
            }
        }
        .accentColor(.dqGreen) // soon deprecated. change to tint.
        .edgesIgnoringSafeArea(.top)
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

extension MainView {
    private enum Tabs {
        case home, bootcamp, club
    }
    
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
