//
//  AdminView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/09/20.
//

import SwiftUI
import SystemConfiguration

struct AdminView: View {
    var mainViewHandler: MainViewHandler
    @State private var tab = Tabs.bootcamp
    
    var body: some View {
        
        VStack {
            Button {
                mainViewHandler.currentPage = SwitchView.main.rawValue
            } label: {
                Text("Go back to dq")
                    .font(.dqLogoFont)
                    .foregroundColor(.dqGreen)
            }
            
            TabView(selection: $tab) {
                AdminBootcampView()
                    .tag(Tabs.bootcamp)
                    .tabItem(image: "laptopcomputer", text: "부트캠프")
                
                AdminClubView()
                    .tag(Tabs.club)
                    .tabItem(image: "person.3.sequence", text: "동아리")
            }
        }
    }
}




//struct AdminView_Previews: PreviewProvider {
//    static var previews: some View {
//        AdminView()
//    }
//}
