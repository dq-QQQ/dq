//
//  LogoImage.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/29.
//
// MyAsyncImage를 사용하면 42서울 로고만 계속 뜸 추후 개선 예정

import SwiftUI

struct LogoImage: View {
    var bootcampList: [BootcampModel]
    @EnvironmentObject private var viewModel: ViewModel
    @Binding var bootcamp : BootcampModel?
    
    var body: some View {
        MyAsyncImage(url: URL(string: bootcamp!.logoURL)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: phoneWidth * 3 / 4, height: phoneWidth * 3 / 4, alignment: .center)
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
