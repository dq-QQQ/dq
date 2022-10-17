//
//  HomeView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/15.
//

import SwiftUI
import Firebase

struct HomeView: View {
    var fbBootcamp: FirebaseBootcamp
    var fbClub: FirebaseClub
    @EnvironmentObject private var viewModel: ViewModel
    @ObservedObject var ho: MainViewHandler
    @Binding var isFirstLaunching: Bool
    
    var body: some View {
        ScrollView {
            Block(title: "관심있어요!", flag: 0, fbBootcamp: fbBootcamp)
            
            spacer
            
            Block(title: "지원기간이 얼마 안남았어요!", flag: 1, fbBootcamp: fbBootcamp)
            
            spacer
            
            Button {
                isFirstLaunching = true
            } label: {
                Text("사용방법 다시")
                    .font(.dqBigFont)
            }
        }
        
    }
}

extension HomeView {
    var spacer: some View {
        Spacer().frame(height: viewModel.getPhoneSize().height / 15)
    }
}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(fbBootcamp: fbBootcamp("BootCamp"),
//                 clubViewModel: ClubViewModel("Club"))
//            .environmentObject(ViewModel())
//    }
//}

