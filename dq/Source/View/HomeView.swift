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
            interestBootcampTitle
            ZStack {
                Rectangle()
                    .frame(height: 200)
                    .foregroundColor(.dqWhite)
                
                ScrollView(.horizontal)  {
                    HStack{
                        ForEach(bootcampList) { bootcamp in
                            let logoSize = (ViewHandler.geoProxy?.size.width ?? 400) / 4
                            VStack {
                                Text(bootcamp.name)
                                    .font(.dqBigSmallFont)
                                    .foregroundColor(.dqGreen)
                                
                                AsyncImage(url: URL(string: bootcamp.logoURL)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: logoSize, height: logoSize)
                                .onTapGesture {
                                    self.showModal = true
                                }
                                .sheet(isPresented: self.$showModal) {
                                    BootcampModalView()
                                }
                            }
                            
                        }
                    }
                    .navigationBarHidden(true)
                    .task {
                        bootcampList = await bootcampViewModel.fetchBootcamp()
//                        bootcampList = bootcampList.filter { $0.isInterested == true}
                    }
                }
            }
            
        }
        .modifier(PaddingFromSide())
    }
}

extension HomeView {
    var interestBootcampTitle: some View {
        HStack {
            Text("관심 있어요!")
            Spacer()
            Image(systemName: "arrow.right")
        }
        .font(.dqBigSmallFont)
    }
    
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(BootcampViewModel())
    }
}

