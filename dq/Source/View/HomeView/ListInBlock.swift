//
//  CustomList.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/29.
//

import SwiftUI

struct ListInBlock: View {
    var flag: Int
    @State var bootcampList: [BootcampModel] = []
    @EnvironmentObject private var viewModel: ViewModel
    @ObservedObject var bootcampViewModel: BootcampViewModel
    
    var body: some View {
        ScrollView(.horizontal)  {
            HStack {
                ElementsInList(bootcampList: $bootcampList, bootcampViewModel: bootcampViewModel)
            }
            .padding(.horizontal, 10)
            .task {
                await processing()
            }
        }
    }
}

private extension ListInBlock {
    func processing() async {
        bootcampList = await bootcampViewModel.fetchFireStore()
        switch flag {
        case 0: // 관심목록
            bootcampList = bootcampList.filter { $0.isInterested == true}
        case 1: // 마감임박순
            bootcampList = bootcampList.sorted {
                $0.applyDeadline.toDateString() < $1.applyDeadline.toDateString()
            }
        default:
            break;
        }
    }
}
