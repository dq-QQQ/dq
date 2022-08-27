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
    @EnvironmentObject private var viewHandler: ViewHandler
    
    var body: some View {
        ScrollView {
            
            titleOfBlock("관심있어요!")
            ZStack {
                blockRectangle
                CustomList(flag: 0, bootcampViewModel: bootcampViewModel)
            }
            .modifier(PaddingFromSideOnHomeView())
            Spacer()
                .frame(height: phoneHeight / 15)
            titleOfBlock("지원기간이 얼마 안남았어요!")
            ZStack {
                blockRectangle
                CustomList(flag: 1, bootcampViewModel: bootcampViewModel)
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
}

struct CustomList: View {
    var flag: Int
    @State var bootcampList: [BootcampModel] = []
    @EnvironmentObject private var viewHandler: ViewHandler
    @ObservedObject var bootcampViewModel: BootcampViewModel
    @State private var showModal = false
    
    var body: some View {
        ScrollView(.horizontal)  {
            HStack {
                ForEach(bootcampList) { field in
                    VStack(alignment: .center, spacing: 5) {
                        nameOfEachField(field)
                        imageOfEachField(field)
                    }
                    .sheet(isPresented: self.$showModal) {
                        BootcampModalView(bootcampList: $bootcampList, bootcamp: field)
                    }
                    .onTapGesture {
                        viewHandler.selection = field.id
                        self.showModal = true
                    }
                    strokeLine
                }
            }
            .padding(.horizontal, 10)
            .task {
                bootcampList = await bootcampViewModel.fetchFireStore()
                switch flag {
                case 0: // 관심목록
                    bootcampList = bootcampList.filter { $0.isInterested == true}
                case 1: // 마감임박순
                    bootcampList = bootcampList.sorted {
                        $0.applyDeadline.toDateString() < $1.applyDeadline.toDateString()
                    }
                default:
                    break;
                }
            }
        }
    }
}

extension CustomList {
    var phoneWidth: CGFloat { viewHandler.getGeoProxy()?.size.width ?? 400 }
    var phoneHeight: CGFloat { viewHandler.getGeoProxy()?.size.height ?? 800 }
    var logoSize: CGFloat { phoneWidth / 4 }
    
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
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(bootcampViewModel: BootcampViewModel("BootCamp"),
                 clubViewModel: ClubViewModel("Club"))
            .environmentObject(ViewHandler())
    }
}

