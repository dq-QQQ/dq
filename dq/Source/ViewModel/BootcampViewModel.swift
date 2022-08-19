//
//  ViewModel.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/17.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class BootcampViewModel: ObservableObject {
    private let dbCollection = Firestore.firestore().collection("BootCamp")
    private var db: [BootcampModel]?
    
    func newBootcamp(name: String, process: String) async -> [BootcampModel] {
        let bootcamp = BootcampModel(id: UUID().uuidString, name: name, process: process)
        _ = try? dbCollection.addDocument(from: bootcamp)
        return await fetchBootcamp()
    }
    
    func fetchBootcamp() async -> [BootcampModel] {
        guard let snapshot = try? await dbCollection.getDocuments() else {
            return []
        }
        
        let bootcampList: [BootcampModel] = snapshot.documents.compactMap { document in
            try? document.data(as: BootcampModel.self)
        }
        
        return bootcampList
    }
}
