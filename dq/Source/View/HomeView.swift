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
    @State private var selection: String? = "Pro"
    @State var bootcampList: [BootcampModel] = []
    
    var body: some View {
        ScrollView {
            HStack {
                Text("관심 있어요!")
                Spacer()
                Image(systemName: "arrow.right")
            }
            .font(.dqBigSmallFont)
            
            ZStack {
                Rectangle()
                    .frame(height: 200)
                    .foregroundColor(.dqWhite)
                    .cornerRadius(20)
                
                ScrollView(.horizontal)  {
                    HStack {
                        ForEach(bootcampList) { bootcamp in
                            let logoSize = (ViewHandler.geoProxy?.size.width ?? 400) / 4
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
                                .frame(width: logoSize, height: (ViewHandler.geoProxy?.size.height ?? 400) / 7)
                            }
                            .sheet(isPresented: self.$showModal) {
                                BootcampModalView(bootcampList: $bootcampList, bootcampID: $selection)
                            }
                            .onTapGesture {
                                selection = bootcamp.id
                                self.showModal = true
                            }
                                Rectangle()
                                    .size(width: 1, height: 180)
                                    .foregroundColor(.gray)
                                    .padding(.vertical, 10)
                                    .padding(.leading, 10)
                                    

                        }
                    }
                    .padding(.horizontal, 10)
                    .navigationBarHidden(true)
                    .task {
                        print(fields.Android)
                        bootcampList = await bootcampViewModel.fetchBootcamp()
                        //                        bootcampList = bootcampList.filter { $0.isInterested == true}
                    }
                }
            }
            
        }
        .modifier(PaddingFromSide())
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(BootcampViewModel())
    }
}

