//
//  FieldsList.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/29.
//

import SwiftUI

struct FieldsList: View {
    var vh2 =  VH2()
    @ObservedObject var bootcampViewModel: BootcampViewModel
    @Binding var bootcampList: [BootcampModel]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Fields.allCases, id: \.self) { field in
                    Button {
                        vh2.currentPage = field.rawValue
                        if vh2.currentPage == Fields.All.rawValue {
                            Task { bootcampList = await bootcampViewModel.fetchFireStore() }
                        } else {
                            Task { bootcampList = await bootcampViewModel.fetchFireStore()
                                bootcampList = bootcampList.filter { $0.process.contains(vh2.currentPage) == true
                                }
                            }
                        }
                    } label: {
                        Text(field.rawValue)
                            .foregroundColor(.dqGray)
                    }
                    .padding(.trailing)
                }
            }
            .modifier(PaddingFromSideOnHomeView())
        }
    }
}
//
//struct FieldsList_Previews: PreviewProvider {
//    static var previews: some View {
//        FieldsList()
//    }
//}
