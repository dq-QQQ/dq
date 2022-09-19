//
//  ClubViewModel.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/09/09.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class FirebaseClub: FirebaseLogic<ClubModel> {
    func newClub(name: String, process: [String]) async {
        let tmp = ClubModel(id: UUID().uuidString, name: name, process: process, time: Timestamp())
        _ = try? dbCollection.addDocument(from: tmp)
    }
}
