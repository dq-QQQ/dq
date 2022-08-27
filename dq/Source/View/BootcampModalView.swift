//
//  BootcampModalView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/17.
//
//                    ForEach(FieldsValue.allCases) {
//                        Text($0)
//                    }

import SwiftUI

struct BootcampModalView: View {
    @Binding var bootcampList: [BootcampModel]
    @EnvironmentObject private var viewHandler: ViewHandler
    @State var bootcamp : BootcampModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                logoImage
                Spacer()
                    .frame(height: 30)
                HStack {
                    infoKey
                    infoValue
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    backButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    setInterest
                }
            }
        }
    }
}

extension BootcampModalView {
    var phoneWidth: CGFloat { viewHandler.getGeoProxy()?.size.width ?? 400 }
    var phoneHeight: CGFloat { viewHandler.getGeoProxy()?.size.height ?? 800 }
    
    var logoImage: some View {
        AsyncImage(url: URL(string: bootcamp.logoURL)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: phoneWidth - 20, height: phoneHeight / 4, alignment: .center)
        .onAppear {
            bootcamp = bootcampList.filter { $0.id == viewHandler.selection}[0]
        }
    }
    
    var infoKey: some View {
        VStack() {
            ForEach(FieldsInfo.allCases, id: \.self) {info in
                VStack {
                    Text(info.rawValue)
                        .modifier(TextStyleInModalView())
                }
            }
        }
        .frame(width: phoneWidth / 3 - phoneWidth / 40)
        .background(Rectangle().fill(Color.dqWhite))
        .cornerRadius(30, corners: [.topLeft, .bottomLeft])
    }
    
    var infoValue: some View {
        VStack() {
            Group {
                Text(bootcamp.name)
                Text(bootcamp.process.reduce("") { $0 + $1 })
                Text(bootcamp.applyDeadline.toDateString())
                Link(bootcamp.homepage, destination: URL(string: bootcamp.homepage)!)
                Text(bootcamp.fee)
                Text(bootcamp.place[1])
                Text(bootcamp.period)
            }
            .modifier(TextStyleInModalView())
        }
        .frame(width: phoneWidth * 2 / 3 - phoneWidth / 40)
        .background(Rectangle().strokeBorder(Color.dqWhite, lineWidth: 2))
    }
    
    var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label : {
            Image(systemName: "chevron.left")
                .modifier(ToolbarStyleInModalView(flag: 0, logoSize: phoneWidth / 10))
        }
    }
    
    var setInterest: some View {
        Button {
        } label : {
            Text("찜하기")
                .modifier(ToolbarStyleInModalView(flag: 1, logoSize: phoneWidth / 10))
        }
    }
}


//struct BootcampModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        BootcampModalView(bootcampList: <#T##Binding<[BootcampModel]>#>, bootcamp: <#T##BootcampModel#>)
//    }
//}
