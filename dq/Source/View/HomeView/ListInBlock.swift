//
//  CustomList.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/29.
//

import SwiftUI

struct ListInBlock: View {
    var flag: Int
    var fbBootcamp: FirebaseBootcamp
    @State var bootcampList: [BootcampModel] = []
    @EnvironmentObject private var viewModel: ViewModel
    @FetchRequest( sortDescriptors: [] ) var list: FetchedResults<InterestedList>
    
    var body: some View {
        if bootcampList.count == 0 && flag == 0 {
            Text("관심목록을 추가해보세요!")
                .foregroundColor(.dqGreen)
                .font(.dqBigSmallFont)
                .frame(width: viewModel.getPhoneSize().width - 50, alignment: .center)
        }
        ScrollView(.horizontal)  {
            if #available(iOS 15.0, *) {
                content
                    .task { await processing() }
            } else {
                content
                    .onAppear() { Task { await processing() } }
            }
        }
    }
}

private extension ListInBlock {
    private var content: some View {
        HStack {
            ElementsInList(bootcampList: $bootcampList, flag: flag)
        }
        .padding(.top, 20)
        .padding(.horizontal, 10)
    }
    
    func processing() async {
        bootcampList = await fbBootcamp.fetchFireStore()
        switch flag {
        case 0: // 관심목록
            bootcampList = bootcampList.filter {
                for element in list {
                    if element.elementID == $0.id {
                        return true
                    }
                }
                return false
            }
        case 1: // 마감임박순
            bootcampList = bootcampList.sorted {
                $0.applyDeadline.toDateString(flag: 0) < $1.applyDeadline.toDateString(flag: 0)
            }
        default:
            break;
        }
    }
}
