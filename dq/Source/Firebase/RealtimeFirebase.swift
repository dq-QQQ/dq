//
//  RealTimeFirebase.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/09/20.
//

import Firebase

class RealtimeFirebase: ObservableObject {
    let realTimeDB = Database.database(url: realTimeDbURL).reference()
    @Published var value = ""
    
    func setAdminUUID() {
        realTimeDB.child("admin").observeSingleEvent(of: .value) {snapshot in
            self.value = snapshot.value as? String ?? "1234"
        }
    }
    
    func getAdminUUID() -> String {
        value
    }
}
