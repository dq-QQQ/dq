//
//  CustomFirebase.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/20.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class FirebaseBootcamp: FirebaseLogic<BootcampModel> {
    func newBootcamp() async {
        let tmp = BootcampModel(id: UUID().uuidString, name: "tmp", process: ["cs"], applyDeadline: Timestamp(), homepage: "q", period: "q", place: ["1234","1234"], fee: "1234", organizer: "1234")
        _ = try? dbCollection.addDocument(from: tmp)
    }
}

