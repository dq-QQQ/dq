//
//  BootcampView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/15.
//

import SwiftUI

struct BootcampView: View {
    var fbBootcamp: FirebaseBootcamp
    @EnvironmentObject var viewModel: ViewModel
    @State var bootcampList: [BootcampModel] = []
    @State var searchText = ""
    
    var body: some View {
        VStack {
            FieldsList(fbBootcamp: fbBootcamp, bootcampList: $bootcampList)
            hr 
            SearchBar(text: $searchText).padding(.top, 10)
            Bootcamps(fbBootcamp: fbBootcamp, bootcampList: $bootcampList, searchText: $searchText)
        }
    }
}

extension BootcampView {
    var phoneWidth: CGFloat { viewModel.getPhoneSize().width }
    
    var hr: some View {
        Rectangle()
            .foregroundColor(.dqWhite)
            .frame(width: phoneWidth, height: 1)
    }

}



//struct BootcampView_Previews: PreviewProvider {
//    static var previews: some View {
//        BootcampView()
//    }
//}
