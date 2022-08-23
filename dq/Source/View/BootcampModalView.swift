//
//  BootcampModalView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/17.
//

import SwiftUI

struct BootcampModalView: View {
    @Binding var bootcampList: [BootcampModel]
    @EnvironmentObject private var viewHandler: ViewHandler
    @State var bootcamp : BootcampModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                AsyncImage(url: URL(string: bootcamp.logoURL)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .onAppear {
                    bootcamp = bootcampList.filter { $0.id == viewHandler.selection}[0]
                }
                .frame(width: (viewHandler.getGeoProxy()?.size.width)! - 20, height: (viewHandler.getGeoProxy()?.size.height)! / 4, alignment: .center)
                
               
                Spacer()
                    .frame(height: 30)
                
                HStack {
                    VStack() {
                        ForEach(FieldsInfo.allCases, id: \.self) {info in
                            VStack {
                                Text(info.rawValue)
                                    .foregroundColor(.dqGreen)
                                    .padding(.vertical)
                                    .font(.dqMediumBigFont)
                                
                            }
                        }
                    }
                    .foregroundColor(.dqGreen)
                    .font(.dqMediumBigFont)
                    .frame(width: (viewHandler.getGeoProxy()?.size.width ?? 400) / 3 - (viewHandler.getGeoProxy()?.size.width ?? 400) / 40)
                    .background(Rectangle().fill(Color.dqWhite))
                    .cornerRadius(30, corners: [.topLeft, .bottomLeft])

                    VStack() {
                        Text(bootcamp.name)
                            .padding(.vertical)

                        Text(bootcamp.process.reduce("") { $0 + $1 })
                            .padding(.vertical)

                        Text(bootcamp.time.toDateString())
                            .padding(.vertical)

                        Link(bootcamp.homepage, destination: URL(string: bootcamp.homepage)!)
                            .padding(.vertical)
                    }
//                    ForEach(FieldsValue.allCases) {
//                        Text($0)
//                    }
                    .foregroundColor(.dqGreen)
                    .font(.dqMediumBigFont)
                    .frame(width: (viewHandler.getGeoProxy()?.size.width ?? 400) * 2 / 3 - (viewHandler.getGeoProxy()?.size.width ?? 400) / 40)
                    .background(Rectangle().strokeBorder(Color.dqWhite, lineWidth: 2))
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label : {
                        Image(systemName: "chevron.left")
                            .frame(width: 40, height: 40)
                            .foregroundColor(.dqGreen)
                            .background(
                                Rectangle()
                                    .fill(Color.dqWhite)
                                    .cornerRadius(10)
                            )
                        //                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 2, y: 2)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                    } label : {
                        Text("찜하기")
                            .frame(width: 80, height: 40)
                            .foregroundColor(.dqGreen)
                            .background(
                                Rectangle()
                                    .fill(Color.dqWhite)
                                    .cornerRadius(10)
                            )
                        //                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 2, y: 2)
                    }
                }
            }
        }
        
    }
}

//struct BootcampModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        BootcampModalView(bootcampList: <#T##Binding<[BootcampModel]>#>, bootcamp: <#T##BootcampModel#>)
//    }
//}
