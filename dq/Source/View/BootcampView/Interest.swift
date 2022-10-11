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
    @EnvironmentObject var coredataStack: CoreDataStack
    @EnvironmentObject private var userNotificationViewModel: UserNotificationViewModel
    @EnvironmentObject private var toastViewModel: ToastViewModel
    
    var body: some View {
        VStack {
            let isInterested = isInterested(id: bootcamp.id)
            if isInterested.0 {
                notInterestedBootcamp(idx: isInterested.1)
            } else {
                interestedBootcamp
                    
            }
            Spacer()
            EmptyView()
        }
    }
}

extension Interest {
    func isInterested(id: String) -> (Bool, Int) {
        for i in list.indices {
            if list[i].elementID == id {
                return (true, i)
            }
        }
        return (false, -1)
    }
    
    func notInterestedBootcamp(idx: Int) -> some View {
        Button {
            moc.delete(list[idx])
            try? moc.save()
            userNotificationViewModel.removeNotification(id: bootcamp.id)
            withAnimation {
                toastViewModel.toggleData(flag: false)
            }
        } label: {
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(.dqRed)
                .padding([.top, .trailing], 5)
        }
        
    }
    
    var interestedBootcamp: some View {
        Button {
            coredataStack.appendInterestedList(element: bootcamp.name,
                                               date: bootcamp.applyDeadline.toDateString(flag: 1),
                                               id: bootcamp.id,
                                               flag: 0)
            coredataStack.save()
            userNotificationViewModel
                .addNotification(id: bootcamp.id,
                                 name: bootcamp.name,
                                 expireDate: bootcamp.applyDeadline.toDateString(flag: 1),
                                 flag: 0)
            withAnimation {
                toastViewModel.toggleData(flag: true)
            }
        } label: {
            Image(systemName: "heart")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(.dqRed)
                .padding([.top, .trailing], 5)
        }
    }
}

//
//struct Interest_Previews: PreviewProvider {
//    static var previews: some View {
//        Interest()
//    }
//}
