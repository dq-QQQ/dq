//
//  Interest.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/29.
//

import SwiftUI

struct Interest: View {
    var bootcamp: BootcampModel
    @FetchRequest( sortDescriptors: [] ) var list: FetchedResults<InterestedList>
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        VStack {
            let whether = isInterested(id: bootcamp.id)
            if whether.0 {
                Button {
                    moc.delete(list[whether.1])
                } label: {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.red)
                        .padding([.top, .trailing], 5)
                }
            } else {
                Button {
                    let interestedList = InterestedList(context: moc)
                    interestedList.elementName = bootcamp.name
                    interestedList.expireDate = bootcamp.applyDeadline.toDateString()
                    interestedList.elementID = bootcamp.id
                    try? moc.save()
                } label: {
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.red)
                        .padding([.top, .trailing], 5)
                }
            }
            Spacer()
            EmptyView()
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
//
//struct Interest_Previews: PreviewProvider {
//    static var previews: some View {
//        Interest()
//    }
//}
