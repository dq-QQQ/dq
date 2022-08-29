//
//  Interest.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/29.
//

import SwiftUI

struct Interest: View {
    var bootcamp: BootcampModel
    
    var body: some View {
        VStack {
            if bootcamp.isInterested == true {
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.red)
                    .padding([.top, .trailing], 5)
            } else {
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.red)
                    .padding([.top, .trailing], 5)
            }
            Spacer()
            EmptyView()
        }
    }
}
//
//struct Interest_Previews: PreviewProvider {
//    static var previews: some View {
//        Interest()
//    }
//}
