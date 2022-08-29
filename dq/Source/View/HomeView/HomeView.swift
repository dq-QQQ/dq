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
    
    var body: some View {
        ScrollView {
            Block(title: "관심있어요!", flag: 0, bootcampViewModel: bootcampViewModel)
            
            Spacer()
                .frame(height: phoneHeight / 15)
            
            Block(title: "지원기간이 얼마 안남았어요!", flag: 1, bootcampViewModel: bootcampViewModel)
        }
    }
}

extension HomeView {
    var phoneWidth: CGFloat { viewModel.getPhoneSize().width }
    var phoneHeight: CGFloat { viewModel.getPhoneSize().height  }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(bootcampViewModel: BootcampViewModel("BootCamp"),
                 clubViewModel: ClubViewModel("Club"))
            .environmentObject(ViewModel())
    }
}

