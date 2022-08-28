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
    @State private var searchText = ""
    
    var body: some View {
        VStack {
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
                .foregroundColor(.dqWhite)
                .frame(width: phoneWidth, height: 1)
            
            
            ScrollView(showsIndicators: true) {
                SearchBar(text: $searchText)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                ForEach(bootcampList.filter{$0.name.hasPrefix(searchText)}) { field in
                    HStack {
                        imageOfEachField(field)
                            .padding(.trailing)
                        VStack(alignment: .leading) {
                            Text(field.name)
                                .font(.dqBigSmallFont)
                                .padding(.bottom, 2)
                            Group {
                                HStack {
                                    Text("과정: ")
                                    if field.process.count >= 2 {
                                        Text("다양")
                                    } else {
                                        Text(field.process[0])
                                    }
                                }
                                HStack {
                                    Text("비용: ")
                                    Text(field.fee)
                                }
                                HStack {
                                    Text("장소: ")
                                    Text(field.place[0])
                                }
                            }
                            .font(.dqMediumBigFont)
                            .padding(.bottom, 1)
                        }
                        .foregroundColor(.dqGreen)
                        .lineLimit(1)
                        .frame(width: logoSize * 2 - phoneWidth / 5, alignment: .leading)
                        VStack {
                            if field.isInterested == true {
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.red)
                                    .padding([.top, .trailing], 5)
                            } else {
                                Image(systemName: "heart")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.red)
                                    .padding([.top, .trailing], 5)
                            }
                            Spacer()
                            EmptyView()
                        }
                    }
                    .background(Color.primary.colorInvert())
                    .cornerRadius(6)
                    .shadow(color:.dqGray, radius: 6)
                    .padding([.leading, .top, .trailing])
                    .sheet(isPresented: self.$showModals) {
                        BootcampModalView(bootcampList: $bootcampList, bootcamp: field)
                    }
                    .onTapGesture {
                        viewHandler.selection = field.id
                        self.showModals = true
                        hideKeyboard()
                    }
                }
            }
            .task {
                bootcampList = await bootcampViewModel.fetchFireStore()
                
            }
        }
    }
}


extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension BootcampView {
    var phoneWidth: CGFloat { viewHandler.getGeoProxy()?.size.width ?? 400 }
    var phoneHeight: CGFloat { viewHandler.getGeoProxy()?.size.height ?? 800 }
    var logoSize: CGFloat { phoneWidth / 3 }
    
    
    func imageOfEachField(_ bootcamp: BootcampModel) -> some View {
        AsyncImage(url: URL(string: bootcamp.logoURL)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: logoSize, height: logoSize)
        
        
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

struct SearchBar: View {
    
    @Binding var text: String
 
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
 
                TextField("Search", text: $text)
                    .foregroundColor(.primary)
 
                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                } else {
                    EmptyView()
                }
            }
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
        }
        .padding(.horizontal)
    }
}

//struct BootcampView_Previews: PreviewProvider {
//    static var previews: some View {
//        BootcampView()
//    }
//}
