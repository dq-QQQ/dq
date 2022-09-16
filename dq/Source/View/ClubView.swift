//
//  ClubView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/15.
//

import SwiftUI

struct ContactView: View {
    let element: InterestedList
    var body: some View {
        HStack {
            Text(element.elementName ?? "-")
            Spacer()
            Text(element.elementID ?? "-")
        }
    }
}

struct ClubView: View {
    @FetchRequest( sortDescriptors: [] ) var list: FetchedResults<InterestedList>
    @Environment(\.managedObjectContext) var moc
    //    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        VStack {
            Button {
                let interestedList = InterestedList(context: moc)
                interestedList.elementName = "kyu"
                interestedList.expireDate = "10101"
                interestedList.elementID = UUID().uuidString
                try? moc.save()
            } label: {
                Image(systemName: "plus")
            }

            List(list, id: \.self) {
                ContactView(element: $0)
            }
        }
    }
}

//struct ClubView_Previews: PreviewProvider {
//    static var previews: some View {
//        ClubView()
//    }
//}
