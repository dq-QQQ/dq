//
//  BootcampView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/15.
//

import SwiftUI

struct BootcampView: View {
    @ObservedObject var bootcampViewModel: BootcampViewModel
    @EnvironmentObject var viewHandler: ViewHandler
    var viewHandler2 =  ViewHandler2()
    @State var bootcampList: [BootcampModel] = []
    @State var showModals: Bool = false
    
    var body: some View {
        ScrollView {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Fields.allCases, id: \.self) { field in
                        Button {
                            viewHandler2.currentPage = field.rawValue
                            if viewHandler2.currentPage == Fields.All.rawValue {
                                Task { bootcampList = await bootcampViewModel.fetchFireStore() }
                            } else {
                                Task { bootcampList = await bootcampViewModel.fetchFireStore()
                                    bootcampList = bootcampList.filter { $0.process.contains(viewHandler2.currentPage) == true
                                    }
                                }
                            }
                        } label: {
                            Text(field.rawValue)
                                .foregroundColor(.dqGray)
                        }
                        .padding(.trailing)
                    }
                }
                .modifier(PaddingFromSideOnHomeView())
            }
            Rectangle()
                .foregroundColor(.dqGray)
                .frame(width: phoneWidth, height: 1)
            
            
            ForEach(bootcampList) { field in
                VStack(alignment: .center, spacing: 5) {
                    nameOfEachField(field)
                    imageOfEachField(field)
                    strokeLine
                }
                .sheet(isPresented: self.$showModals) {
                    BootcampModalView(bootcampList: $bootcampList, bootcamp: field)
                }
                .onTapGesture {
                    viewHandler.selection = field.id
                    self.showModals = true
                }
                
            }
        }
        .task {
            bootcampList = await bootcampViewModel.fetchFireStore()
            
        }
    }
}

extension BootcampView {
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

//struct BootcampView_Previews: PreviewProvider {
//    static var previews: some View {
//        BootcampView()
//    }
//}
