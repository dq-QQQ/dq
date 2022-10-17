//
//  AdminBootcampView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/10/16.
//

import SwiftUI


struct AdminBootcampView: View {
    var fbBootcamp = FirebaseBootcamp("BootCamp")
    @State var date = Date()
    @State var bootcampList: [BootcampModel] = []
    
    var body: some View {
        ScrollView() {
            CollapsibleView( label: { updateData }, content: {
                EmptyView()
            }, bootcampList: $bootcampList, fbBootcamp: fbBootcamp, date: $date, flag: (0,0))
            
//            CollapsibleView( label: { addData }, content: {
//                EmptyView()
//            }, bootcampList: $bootcampList, fbBootcamp: fbBootcamp, date: $date, flag: (0,1))
//            
            
            Spacer()
        }
        .task {
            bootcampList = await fbBootcamp.fetchFireStore()
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension AdminBootcampView {
    var updateData: Text {
        Text("데이터 수정")
            .font(.dqBigSmallFont)
            .foregroundColor(.dqGreen)
    }
    
    var addData: Text {
        Text("데이터 추가")
            .font(.dqBigSmallFont)
            .foregroundColor(.dqGreen)
    }
    
//    var addElements: some View {
//        VStack {
//            BootcampModel(
//        }
//    }
}



struct AdminBootcampView_Previews: PreviewProvider {
    static var previews: some View {
        AdminBootcampView()
    }
}
