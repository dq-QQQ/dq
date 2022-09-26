//
//  Bootcamps.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/29.
//

import SwiftUI

struct Bootcamps: View {
    var fbBootcamp: FirebaseBootcamp
    @EnvironmentObject var viewModel: ViewModel
    @State var showModals: Bool = false
    @Binding var bootcampList: [BootcampModel]
    @Binding var searchText: String
    
    var body: some View {
        if #available(iOS 15.0, *) {
            content
                .task { bootcampList = await fbBootcamp.fetchFireStore() }
        } else {
            content
                .onAppear() { Task { bootcampList = await fbBootcamp.fetchFireStore() } }
        }
    }
}

extension Bootcamps {
    var phoneWidth: CGFloat { viewModel.getPhoneSize().width }
    var phoneHeight: CGFloat { viewModel.getPhoneSize().height  }
    var logoSize: CGFloat { phoneWidth / 3 }
    
    private var content: some View {
        ScrollView(showsIndicators: false) {
            ForEach(bootcampList.filter{$0.name.hasPrefix(searchText)}) { bootcamp in
                HStack {
                    imageOfEachField(bootcamp).padding(.trailing)
                    ShortInfo(bootcamp: bootcamp)
                    Interest(bootcamp: bootcamp)
                    
                }
                .background(Color.primary.colorInvert())
                .cornerRadius(6)
                .shadow(color:.dqGray, radius: 6)
                .padding([.leading, .top, .trailing])
                .onTapGesture {
                    viewModel.selection = bootcamp.id
                    self.showModals = true
                    hideKeyboard()
                }
                .sheet(isPresented: self.$showModals) {
                    BootcampModalView(bootcampList: $bootcampList)
                }
            }
        }
    }
    
    func imageOfEachField(_ bootcamp: BootcampModel) -> some View {
        MyAsyncImage(url: URL(string: bootcamp.logoURL)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: logoSize, height: logoSize)
    }
    
}
//
//struct Bootcamps_Previews: PreviewProvider {
//    static var previews: some View {
//        Bootcamps()
//    }
//}
