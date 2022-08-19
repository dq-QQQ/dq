//
//  HomeView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/15.
//

import SwiftUI

struct HomeView: View {
    @State private var showModal = false
    @EnvironmentObject private var bootcampViewModel: BootcampViewModel
    
    @State var bootcampList: [BootcampModel] = []
    var body: some View {
        ScrollView {
            HStack {
                Text("관심 있어요!")
                Spacer()
                Image(systemName: "arrow.right")
            }
            .font(.dqBigSmallFont)
            .modifier(PaddingFromSide())
            List(bootcampList) { bootcamp in
                NavigationLink(destination: BootcampModalView()) {
                    VStack(alignment: .leading) {
                        Text(bootcamp.name)
                            .font(.headline)
                            .fontWeight(.bold)
                        Text(bootcamp.process)
                    }
                }
            }
        }
        .task {
            bootcampList = await ho.fetchBootcamp()
            print(bootcampList)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(BootcampViewModel())
    }
}
