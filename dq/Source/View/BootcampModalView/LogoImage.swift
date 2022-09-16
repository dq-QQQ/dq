//
//  LogoImage.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/29.
//

import SwiftUI

struct LogoImage: View {
    @EnvironmentObject private var viewModel: ViewModel
    @Binding var bootcampList: [BootcampModel]
    @Binding var bootcamp : BootcampModel
    
    var body: some View {
        AsyncImage(url: URL(string: bootcamp.logoURL)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: phoneWidth - 20, height: phoneHeight / 4, alignment: .center)
        .onAppear {
            bootcamp = bootcampList.filter { $0.id == viewModel.selection}[0]
            print(bootcamp.name)
        }
    }
}

private extension LogoImage {
    var phoneWidth: CGFloat { viewModel.getPhoneSize().width }
    var phoneHeight: CGFloat { viewModel.getPhoneSize().height }
}

//struct LogoImage_Previews: PreviewProvider {
//    static var previews: some View {
//        LogoImage()
//    }
//}
