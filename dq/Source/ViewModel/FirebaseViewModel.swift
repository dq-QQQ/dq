//
//  CustomFirebase.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/20.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class BootcampViewModel: FirebaseModel<BootcampModel>, ObservableObject {
    @Published var bootcampList: [[BootcampModel]] = [[]]
//    
//    func newBootcamp() async {
//        let tmp = BootcampModel(id: UUID().uuidString, name: "코드 스타터 캠프", process: ["iOS"], isInterested: true,applyDeadline: Timestamp(), homepage: "",period: "5주", place: ["온라인", "온라인"], fee: "55만원")
//        _ = try? dbCollection.addDocument(from: tmp)
//    }
}

class ClubViewModel: FirebaseModel<ClubModel>, ObservableObject {
    func newClub(name: String, process: [String]) async {
        let tmp = ClubModel(id: UUID().uuidString, name: name, process: process, time: Timestamp())
        _ = try? dbCollection.addDocument(from: tmp)
    }
}
