//
//  FieldsList.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/29.
//

import SwiftUI

struct FieldsList: View {
    var fbBootcamp: FirebaseBootcamp
    @ObservedObject var fieldsViewHandler =  FieldsViewHandler()
    @Binding var bootcampList: [BootcampModel]
    @State var selectedFields: Fields = .All
    @State var width: CGFloat = 80
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Fields.allCases, id: \.self) { field in
                    VStack {
                        fieldButton(field: field)
                        if field == selectedFields {
                            emphasizingRectangle(field: field)
                        }
                    }
                    .padding(.trailing)
                }
            }
            .modifier(PaddingFromSideOnHomeView())
        }
        .onDisappear {
            selectedFields = .All
        }
    }
}

extension FieldsList {
    func fieldButton(field: Fields) -> some View {
        Button {
            onClickButton(field: field)
        } label: {
            Text(field.rawValue)
                .foregroundColor(.dqGray)
        }
    }
    
    func emphasizingRectangle(field: Fields) -> some View {
        Rectangle()
            .frame(width: width, height: 3)
            .foregroundColor(Color.dqGreen)
            .alignmentGuide(.horizontalAlignment,
                            computeValue: { dimension in
                dimension[HorizontalAlignment.center]
            })
            .onAppear {
                switch field.rawValue.count {
                case 0..<4: width = 40
                case 4..<9: width = 80
                default:
                    width = 120
                }
            }
    }
    
    func onClickButton(field: Fields) {
        fieldsViewHandler.currentPage = field.rawValue
        selectedFields = field
        if fieldsViewHandler.currentPage == Fields.All.rawValue {
            Task { bootcampList = await fbBootcamp.fetchFireStore() }
        } else {
            Task { bootcampList = await fbBootcamp.fetchFireStore()
                bootcampList = bootcampList.filter { $0.process.contains(fieldsViewHandler.currentPage) == true
                }
            }
        }
    }
}


//
//struct FieldsList_Previews: PreviewProvider {
//    static var previews: some View {
//        FieldsList()
//    }
//}
