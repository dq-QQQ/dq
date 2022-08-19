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
            AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/dqapp-d00bb.appspot.com/o/42Seoul.png?alt=media&token=36f7eb9b-6a97-4f9c-aced-2c686f48a95b")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            .onTapGesture {
                bootcampViewModel.UpdateBootcamp(bootcamp: bootcampViewModel.getDB()[0])
            }
//            List(bootcampList) { bootcamp in
//                NavigationLink(destination: BootcampModalView()) {
//                    VStack(alignment: .leading) {
//                        Text(bootcamp.name)
//                            .font(.headline)
//                            .fontWeight(.bold)
//                        Text(bootcamp.process)
//                    }
//                }
//            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(BootcampViewModel())
    }
}
