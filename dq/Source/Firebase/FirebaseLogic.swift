//
//  FirebaseViewModel.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/20.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class FirebaseLogic<T: Identifiable & Codable> {
    let dbCollection: CollectionReference
    
    
    init(_ collectionName: String) {
        dbCollection = Firestore.firestore().collection(collectionName)
    }

    func updateFireStore(data: T)  {
        dbCollection.whereField("id", isEqualTo: data.id).getDocuments { snap, err in
            if err != nil {
                print("Error")
                return
            }
            
            for i in snap!.documents {
                var isInterested = i.get("isInterested") as! Bool
                isInterested.toggle()
                DispatchQueue.main.async {
                    i.reference.updateData(["isInterested":isInterested])
                }
            }
        }
    }
    
    func fetchFireStore() async -> [T] {
        guard let snapshot = try? await dbCollection.getDocuments() else {
            return []
        }
        let data: [T] = snapshot.documents.compactMap { document in
            try? document.data(as: T.self)
        }
        return data
    }
}
