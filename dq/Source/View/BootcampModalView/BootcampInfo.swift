//
//  BootcampInfo.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/29.
//

import SwiftUI

struct BootcampInfo: View {
    @EnvironmentObject private var viewModel: ViewModel
    @Binding var bootcamp : BootcampModel?
    
    var body: some View {
        HStack {
            infoKey
            infoValue
        }
    }
}

private extension BootcampInfo {
    var phoneWidth: CGFloat { viewModel.getPhoneSize().width }
    var phoneHeight: CGFloat { viewModel.getPhoneSize().height }
    
    var infoKey: some View {
        VStack() {
            ForEach(BootcampInformations.allCases, id: \.self) {info in
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
                Text(bootcamp!.name)
                Text(bootcamp!.process.reduce("") { $0 + ($0 == "" ? "" : "/") + $1 })
                Text(bootcamp!.applyDeadline.toDateString(flag: 0))
                Link(destination: URL(string: bootcamp!.homepage)!) { Text("Link").underline() }
                Text(bootcamp!.fee)
                Text(bootcamp!.place[1])
                Text(bootcamp!.period)
                Text(bootcamp!.organizer)
            }
            .modifier(TextStyleInModalView())
        }
        .frame(width: phoneWidth * 2 / 3 - phoneWidth / 40)
        .background(Rectangle().strokeBorder(Color.dqWhite, lineWidth: 2))
    }
}

//struct BootcampInfo_Previews: PreviewProvider {
//    static var previews: some View {
//        BootcampInfo()
//    }
//}
