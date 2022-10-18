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
    @State var values: (info: [String: String], date: Date) = ([:], Date())
    
    var body: some View {
        ScrollView() {
            CollapsibleView( label: { updateData }, content: {
                EmptyView()
            }, bootcampList: $bootcampList, fbBootcamp: fbBootcamp, flag: (0,0), values: $values)
            .padding(.bottom, 30)
            
            CollapsibleView( label: { addData }, content: { addElements }, bootcampList: $bootcampList, fbBootcamp: fbBootcamp, flag: (0,1), values: $values)
                .padding(.bottom, 30)
            
            CollapsibleView( label: { deleteData }, content: {
                EmptyView()
            }, bootcampList: $bootcampList, fbBootcamp: fbBootcamp, flag: (0,2), values: $values)
            
            
            Spacer()
        }
        .task {
            bootcampList = await fbBootcamp.fetchFireStore()
        }
        .padding()
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
    
    var deleteData: Text {
        Text("데이터 삭제")
            .font(.dqBigSmallFont)
            .foregroundColor(.dqGreen)
    }
    
    var addElements: some View {
        Group {
            Group {
            GetSingleString(info: "logoURL", values: $values.info)
            GetSingleString(info: "name", values: $values.info)
            GetSingleString(info: "homepage", values: $values.info)
            GetSingleString(info: "period", values: $values.info)
            GetSingleString(info: "fee", values: $values.info)
            GetSingleString(info: "organizer", values: $values.info)
            GetSingleString(info: "process", values: $values.info)
            GetSingleString(info: "place", values: $values.info)
            GetSingleString(info: "curriculum", values: $values.info)
            GetSingleString(info: "selection", values: $values.info)
            }
            DatePicker("duedate", selection: $values.date,
                       displayedComponents: [.date, .hourAndMinute])
            
        }
        .padding()
    }
}

struct GetSingleString: View{
    @State private var value = ""
    var info: String
    @Binding var values: [String: String]
    
    var body: some View {
        HStack {
            Text(info)
            Spacer()
            TextField("", text: $value)
                .background{
                    Rectangle()
                        .stroke()
                }
                .frame(width: 160)
            Button {
                values.updateValue(value, forKey: info)
            } label: {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.dqGreen)
            }

        }
    }
}




struct AdminBootcampView_Previews: PreviewProvider {
    static var previews: some View {
        AdminBootcampView()
    }
}
