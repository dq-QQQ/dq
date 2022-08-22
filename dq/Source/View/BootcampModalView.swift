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
                .frame(width: (viewHandler.getGeoProxy()?.size.width)! - 20, height: (viewHandler.getGeoProxy()?.size.height)! / 4, alignment: .center)
            Text(bootcamp.name)
                .onAppear {
                    bootcamp = bootcampList.filter { $0.id == viewHandler.selection}[0]
                    print(bootcamp.time.toDateString())
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label : {
                        Image(systemName: "chevron.left")
                            .frame(width: 40, height: 40)
                            .foregroundColor(.dqWhite)
                            .background(
                                Rectangle()
                                    .fill(Color.dqGreen)
                                    .cornerRadius(10)
                            )
                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 2, y: 2)
                            
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                    } label : {
                        Text("찜하기")
                            .frame(width: 80, height: 40)
                            .foregroundColor(.dqWhite)
                            .background(
                                Rectangle()
                                    .fill(Color.dqGreen)
                                    .cornerRadius(10)
                            )
                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 2, y: 2)
                            
                    }
                }
            }
        }
        
    }
}
//
//struct BootcampModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        BootcampModalView()
//    }
//}
