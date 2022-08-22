//
//  HomeView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/15.
//

import SwiftUI

struct HomeView: View {
    @State private var showModal = false
    @ObservedObject var bootcampViewModel: BootcampViewModel
    @EnvironmentObject private var viewHandler: ViewHandler
    @State var bootcampList: [BootcampModel] = []
    
    var body: some View {
        ScrollView {
            Text("관심 있어요!")
                .modifier(PaddingFromSide())
                .frame(width: viewHandler.geoProxy?.size.width, alignment: .leading)
            
                .font(.dqBigSmallFont)
            
            ZStack {
                Rectangle()
                    .frame(height: 200)
                    .foregroundColor(.dqWhite)
                    .cornerRadius(20)
                
                ScrollView(.horizontal)  {
                    HStack {
                        ForEach(bootcampList) { bootcamp in
                            let logoSize = (viewHandler.geoProxy?.size.width ?? 400) / 4
                            VStack(alignment: .center, spacing: 5) {
                                Text(bootcamp.name)
                                    .font(.dqBigSmallFont)
                                    .foregroundColor(.dqGreen)
                                    .lineLimit(2)
                                    .frame(width: logoSize, height: 60)
                                
                                AsyncImage(url: URL(string: bootcamp.logoURL)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: logoSize, height: (viewHandler.geoProxy?.size.height ?? 400) / 7)
                            }
                            .sheet(isPresented: self.$showModal) {
                                BootcampModalView(bootcampList: $bootcampList, ho: bootcamp)
                            }
                            .onTapGesture {
                                viewHandler.selection = bootcamp.id
                                self.showModal = true
                            }
                            Rectangle()
                                .size(width: 1, height: 180)
                                .foregroundColor(.gray)
                                .opacity(0.3)
                                .padding(.vertical, 10)
                                .padding(.leading, 10)
                        }
                    }
                    .padding(.horizontal, 10)
                    .task {
                        bootcampList = await bootcampViewModel.fetchFireStore()
//                        bootcampList = bootcampList.filter { $0.isInterested == true}
                    }
                }
            }
            
            .modifier(PaddingFromSide())
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(bootcampViewModel: BootcampViewModel("BootCamp"))
            .environmentObject(ViewHandler())
    }
}

