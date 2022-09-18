//
//  BootcampModalView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/17.
//

import SwiftUI

struct BootcampModalView: View {
    @EnvironmentObject private var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    @Binding var bootcampList: [BootcampModel]
    @State var bootcamp : BootcampModel
    @FetchRequest( sortDescriptors: [] ) var list: FetchedResults<InterestedList>
    @Environment(\.managedObjectContext) var moc
    
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LogoImage(bootcampList: bootcampList, bootcamp: $bootcamp)
                
                Spacer().frame(height: 30)
                
                BootcampInfo(bootcamp: $bootcamp)
            }
            .onAppear {
                bootcamp = bootcampList.filter { $0.id == viewModel.selection}[0]
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    backButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    setInterest
                }
            }
        }
    }
}

extension BootcampModalView {
    var phoneWidth: CGFloat { viewModel.getPhoneSize().width }
    var phoneHeight: CGFloat { viewModel.getPhoneSize().height }
    
    var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label : {
            Image(systemName: "chevron.left")
                .modifier(ToolbarStyleInModalView(flag: 0, logoSize: phoneWidth / 10))
        }
    }
    
    var setInterest: some View {
        let whether = isInterested(id: bootcamp.id)
        if whether.0 {
            return Button {
                moc.delete(list[whether.1])
                try? moc.save()
            } label: {
                Text("찜하기 해제")
                    .modifier(ToolbarStyleInModalView(flag: 1, logoSize: phoneWidth / 10))
            }
        } else {
            return Button {
                let interestedList = InterestedList(context: moc)
                interestedList.elementName = bootcamp.name
                interestedList.expireDate = bootcamp.applyDeadline.toDateString(flag: 0)
                interestedList.elementID = bootcamp.id
                interestedList.flag = 0
                try? moc.save()
            } label: {
                Text("찜하기")
                    .modifier(ToolbarStyleInModalView(flag: 1, logoSize: phoneWidth / 10))
            }
        }
    }
    
    func isInterested(id: String) -> (Bool, Int) {
        for i in list.indices {
            if list[i].elementID == id {
                return (true, i)
            }
        }
        return (false, -1)
    }
}


//struct BootcampModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        BootcampModalView(bootcampList: <#T##Binding<[BootcampModel]>#>, bootcamp: <#T##BootcampModel#>)
//    }
//}
