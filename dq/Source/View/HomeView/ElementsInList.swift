//
//  ListElements.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/29.
//

import SwiftUI

struct ElementsInList: View {
    @EnvironmentObject private var viewModel: ViewModel
    @Binding var bootcampList: [BootcampModel]
    @State private var showModal = false
    
    var body: some View {
        ForEach(bootcampList) { field in
            VStack(alignment: .center, spacing: 5) {
                nameOfEachField(field)
                imageOfEachField(field)
            }
            .sheet(isPresented: self.$showModal) {
                BootcampModalView(bootcampList: $bootcampList, bootcamp: field)
            }
            .onTapGesture {
                viewModel.selection = field.id
                self.showModal = true
            }
            strokeLine
        }
    }
}

extension ElementsInList {
    var phoneWidth: CGFloat { viewModel.getPhoneSize().width }
    var phoneHeight: CGFloat { viewModel.getPhoneSize().height  }
    var logoSize: CGFloat { phoneWidth / 4 }
    
    func nameOfEachField(_ bootcamp: BootcampModel) -> some View {
        Text(bootcamp.name)
            .font(.dqBigSmallFont)
            .foregroundColor(.dqGreen)
            .lineLimit(2)
            .frame(width: logoSize, height: phoneHeight / 12, alignment: .center)
    }
    
    func imageOfEachField(_ bootcamp: BootcampModel) -> some View {
        MyAsyncImage(url: URL(string: bootcamp.logoURL)) { image in
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

//
//struct ListElements_Previews: PreviewProvider {
//    static var previews: some View {
//        ElementsInList()
//    }
//}
