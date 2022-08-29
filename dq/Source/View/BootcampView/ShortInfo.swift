//
//  ShortInfo.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/29.
//

import SwiftUI

struct ShortInfo: View {
    var bootcamp: BootcampModel
    @EnvironmentObject private var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            name
            info
        }
        .foregroundColor(.dqGreen)
        .lineLimit(1)
        .frame(width: logoSize * 2 - phoneWidth / 5, alignment: .leading)
    }
}

extension ShortInfo {
    var phoneWidth: CGFloat { viewModel.getPhoneSize().width }
    var phoneHeight: CGFloat { viewModel.getPhoneSize().height  }
    var logoSize: CGFloat { phoneWidth / 3 }
    
    var name: some View {
        Text(bootcamp.name)
            .font(.dqBigSmallFont)
            .padding(.bottom, 2)
    }
    
    var info: some View {
        Group {
            HStack {
                Text("과정: ")
                if bootcamp.process.count >= 2 {
                    Text("다양")
                } else {
                    Text(bootcamp.process[0])
                }
            }
            HStack {
                Text("비용: ")
                Text(bootcamp.fee)
            }
            HStack {
                Text("장소: ")
                Text(bootcamp.place[0])
            }
        }
        .font(.dqMediumBigFont)
        .padding(.bottom, 1)
    }
}

//struct ShortInfo_Previews: PreviewProvider {
//    static var previews: some View {
//        ShortInfo()
//    }
//}
