//
//  BootcampModalView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/17.
//

import SwiftUI

struct BootcampModalView: View {
    @EnvironmentObject private var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    @Binding var bootcampList: [BootcampModel]
    @State var bootcamp : BootcampModel
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LogoImage(bootcampList: $bootcampList, bootcamp: $bootcamp)
                
                Spacer().frame(height: 30)
                
                BootcampInfo(bootcamp: bootcamp)
            }
//            .onAppear {
//                bootcamp = bootcampList.filter { $0.id == viewModel.selection}[0]
//                print(bootcamp.name)
//            }
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
    var phoneWidth: CGFloat { viewModel.getPhoneSize().width }
    var phoneHeight: CGFloat { viewModel.getPhoneSize().height }
    
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
