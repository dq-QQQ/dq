//
//  HomeView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/15.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var bootcampViewModel: BootcampViewModel
    @ObservedObject var clubViewModel: ClubViewModel
    @EnvironmentObject private var viewModel: ViewModel
    @ObservedObject var ho: MainViewHandler
    
    var body: some View {
        ScrollView {
            Block(title: "관심있어요!", flag: 0, bootcampViewModel: bootcampViewModel)
            
            Spacer().frame(height: viewModel.getPhoneSize().height / 15)
            
            Block(title: "지원기간이 얼마 안남았어요!", flag: 1, bootcampViewModel: bootcampViewModel)
            
            
            Button {
                ho.currentPage = SwitchView.info.rawValue
            } label: {
                Text("ho")
                    .font(.dqBigFont)
            }

        }
        
    }
}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(bootcampViewModel: BootcampViewModel("BootCamp"),
//                 clubViewModel: ClubViewModel("Club"))
//            .environmentObject(ViewModel())
//    }
//}

