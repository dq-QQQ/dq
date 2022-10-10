//
//  FieldsDescriptionView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/09/27.
//

import SwiftUI

struct FieldsDescriptionView: View {
    @State var showDetail: Bool = false
    @State private var  datas = [ListData]()
    
    var body: some View {
        VStack {
            ForEach(datas) { data in
                FieldRowView(data: data)
                    .frame(height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .padding(.vertical, 8)
                    .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 6)
                    .sheet(isPresented: self.$showDetail) {
                        hoho()
                    }
                    .onTapGesture {
                                showDetail = true
                }
            }
        }
        .onAppear {
            if datas.count == 0 {
                for field in FieldsForDescription.allCases {
                    datas.append(ListData(name: field.rawValue,
                                          description: field.getShortDescription(),
                                          img: Image(systemName: field.getImageName())
                                         ))
                }
            }
        }
    }
}

struct hoho: View {
    var body: some View {
        Text("ho")
    }
}

struct FieldRowView: View {

    let data: ListData
    
    var imageTitleView: some View {
        ZStack(alignment: .bottomLeading) {
            GeometryReader { proxy in
                ZStack {
                    Color.dqVanilla
                }
            }
            .clipShape(Rectangle())
        }
    }
    
    var bottomInfoView: some View {
        ZStack(alignment: .leading){
            Rectangle()
                .fill(Color.dqWhite)
            HStack(alignment: .center) {
                data.img
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .padding(15)
                VStack(alignment: .leading) {
                    Text(data.name)
                        .bold()
                    Text(data.description)
                        .font(.caption)
                        .opacity(0.8)
                }
                Spacer()
                Image(systemName: "arrow.right")
                    .foregroundColor(.dqGreen)
                    .frame(width: 40, height: 40)
            }
            .padding(.leading, 6)
        }
        .frame(maxHeight: 60)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            imageTitleView
            bottomInfoView
        }
    }
}


struct ListData: Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var img: Image
}

//struct FieldsDescriptionView_Previews: PreviewProvider {
//    static var previews: some View {
//        FieldsDescriptionView()
//    }
//}
