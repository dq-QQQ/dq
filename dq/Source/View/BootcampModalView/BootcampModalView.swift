//
//  BootcampModalView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/17.
//

import SwiftUI

struct BootcampModalView: View {
    @EnvironmentObject private var viewModel: ViewModel
    @Binding var bootcampList: [BootcampModel]
    @State var bootcamp : BootcampModel?
    @FetchRequest( sortDescriptors: [] ) var list: FetchedResults<InterestedList>
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var coredataStack: CoreDataStack
    
    
    var body: some View {
        NavigationView {
            if bootcamp == nil {
                EmptyView()
            } else {
                ScrollView(showsIndicators: false) {
                    LogoImage(bootcampList: bootcampList, bootcamp: $bootcamp)
                    
                    Spacer().frame(height: 30)
                    
                    BootcampInfo(bootcamp: $bootcamp)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        goToLink
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        setInterest
                    }
                }
            }
        }
        .onAppear() {
            bootcamp = bootcampList.filter { $0.id == viewModel.selection}[0]
        }
    }
}

extension BootcampModalView {
    var phoneWidth: CGFloat { viewModel.getPhoneSize().width }
    var phoneHeight: CGFloat { viewModel.getPhoneSize().height }
    
    var goToLink: some View {
        Button {
        } label: {
            Link(destination: URL(string: bootcamp!.homepage)!) { Text("홈페이지").underline() }
                .font(.dqBigFont)
                .foregroundColor(.dqGreen)
        }
    }
    
    
    var setInterest: some View {
        let whether = isInterested(id: bootcamp!.id)
        if whether.0 {
            return Button {
                moc.delete(list[whether.1])
                try? moc.save()
            } label: {
                Image(systemName: "heart.fill")
                    .resizable()
                    .modifier(ToolbarStyleInModalView(logoSize: phoneWidth / 12))
            }
        } else {
            return Button {
                coredataStack.appendInterestedList(element: bootcamp!.name,
                                                   date: bootcamp!.applyDeadline.toDateString(flag: 1),
                                                   id: bootcamp!.id,
                                                   flag: 0)
                coredataStack.save()
            } label: {
                Image(systemName: "heart")
                    .resizable()
                    .modifier(ToolbarStyleInModalView(logoSize: phoneWidth / 12))
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
