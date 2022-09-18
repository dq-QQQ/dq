//
//  FieldsList.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/29.
//

import SwiftUI

struct FieldsList: View {
    @ObservedObject var fieldsViewHandler =  FieldsViewHandler()
    @ObservedObject var bootcampViewModel: BootcampViewModel
    @Binding var bootcampList: [BootcampModel]
    @State var selectedFields: Fields = .All
    @State var width: CGFloat = 80
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Fields.allCases, id: \.self) { field in
                    VStack {
                        Button {
                            fieldsViewHandler.currentPage = field.rawValue
                            selectedFields = field
                            if fieldsViewHandler.currentPage == Fields.All.rawValue {
                                Task { bootcampList = await bootcampViewModel.fetchFireStore() }
                            } else {
                                Task { bootcampList = await bootcampViewModel.fetchFireStore()
                                    bootcampList = bootcampList.filter { $0.process.contains(fieldsViewHandler.currentPage) == true
                                    }
                                }
                            }
                        } label: {
                            Text(field.rawValue)
                                .foregroundColor(.dqGray)
                        }
                        if field == selectedFields {
                            Rectangle().frame(width: width, height: 3).foregroundColor(Color.dqGreen)
                                .alignmentGuide(.horizontalAlignment, computeValue: { d in
                                    d[HorizontalAlignment.center] })
                                .onAppear {
                                    switch field.rawValue.count {
                                    case 0..<4: width = 40
                                    case 4..<9: width = 80
                                    default:
                                        width = 120
                                    }
                                }
                        }
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
