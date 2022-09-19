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
    var fbBootcamp: FirebaseBootcamp
    @FetchRequest( sortDescriptors: [] ) var list: FetchedResults<InterestedList>
    
    var body: some View {
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
            ElementsInList(bootcampList: $bootcampList)
        }
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
