//
//  CustomFirebase.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/20.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class BootcampViewModel: FirebaseViewModel<BootcampModel> {
    @Published var bootcampList: [[BootcampModel]] = [[]]
    
//    func newBootcamp(name: String, process: [String]) async {
//        let tmp = BootcampModel(id: UUID().uuidString, name: name, process: process, isInterested: false,time: Timestamp(), homepage: "")
//        _ = try? dbCollection.addDocument(from: tmp)
//    }
}

class ClubViewModel: FirebaseViewModel<ClubModel> {
    func newClub(name: String, process: [String]) async {
        let tmp = ClubModel(id: UUID().uuidString, name: name, process: process, time: Timestamp())
        _ = try? dbCollection.addDocument(from: tmp)
    }
}
