//
//  HomeView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/15.
//

//                        bootcampList = bootcampList.filter { $0.isInterested == true} // 관심목록
//                        bootcampList = bootcampList.sorted { // 마감임박순
//                            $0.time.toDateString() < $1.time.toDateString()
//                        }

import SwiftUI

struct HomeView: View {
    @State private var showModal = false
    @ObservedObject var bootcampViewModel: BootcampViewModel
    @ObservedObject var clubViewModel: ClubViewModel
    @EnvironmentObject private var viewHandler: ViewHandler
//    @State var bootcampList: [BootcampModel] = []
    
    var body: some View {
        ScrollView {
            titleOfBlock("관심있어요!")
            ZStack {
                blockRectangle
                customList
            }
            .modifier(PaddingFromSideOnHomeView())
        }
    }
}

extension HomeView {
    var phoneWidth: CGFloat { viewHandler.getGeoProxy()?.size.width ?? 400 }
    var phoneHeight: CGFloat { viewHandler.getGeoProxy()?.size.height ?? 800 }
    var logoSize: CGFloat { phoneWidth / 4 }
    
    func titleOfBlock(_ a: String) -> some View {
        Text(a)
            .modifier(PaddingFromSideOnHomeView())
            .frame(width: phoneWidth, alignment: .leading)
            .font(.dqBigSmallFont)
    }
    
    var blockRectangle: some View {
        Rectangle()
            .frame(height: phoneHeight / 4)
            .foregroundColor(.dqWhite)
            .cornerRadius(20)
    }
    
    func nameOfEachField(_ bootcamp: BootcampModel) -> some View {
        Text(bootcamp.name)
            .font(.dqBigSmallFont)
            .foregroundColor(.dqGreen)
            .lineLimit(2)
            .frame(width: logoSize, height: phoneHeight / 12)
    }
    
    func imageOfEachField(_ bootcamp: BootcampModel) -> some View {
        AsyncImage(url: URL(string: bootcamp.logoURL)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: logoSize, height: phoneHeight / 7)
    }
    
    var strokeLine: some View {
        Rectangle()
            .size(width: 1, height: (phoneHeight / 4) - 20)
            .foregroundColor(.gray)
            .opacity(0.3)
            .padding(.vertical, phoneWidth / 40)
            .padding(.leading, phoneWidth / 40)
    }

    
    var customList: some View {
        ScrollView(.horizontal)  {
            HStack {
                ForEach(bootcampViewModel.bootcampList) { field in
                    VStack(alignment: .center, spacing: 5) {
                        nameOfEachField(field)
                        imageOfEachField(field)
                    }
                    .sheet(isPresented: self.$showModal) {
                        BootcampModalView(bootcampList: $bootcampViewModel.bootcampList, bootcamp: field)
                    }
                    .onTapGesture {
                        viewHandler.selection = field.id
                        self.showModal = true
                    }
                    strokeLine
                }
            }
            .padding(.horizontal, phoneWidth / 40)
            .task {
                bootcampViewModel.bootcampList = await bootcampViewModel.fetchFireStore()
            }
        }
    }
}

// 모듈화 실패.. 할 수 있을 거 같은데..
// cannot convert value of type to expected argument type 'binding c ' foreach매개변수에 제네릭 변수 넣으면 안됨
//
//struct CustomList<T: Decodable & Encodable & Identifiable>: View {
//    @ObservedObject var firebaseViewModel: FirebaseViewModel<T>
//
//    var body: some View {
//
//    }
//
//}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(bootcampViewModel: BootcampViewModel("BootCamp"),
                 clubViewModel: ClubViewModel("Club"))
            .environmentObject(ViewHandler())
    }
}

