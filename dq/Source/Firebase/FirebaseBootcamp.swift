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
    func newBootcamp(values: (info: [String: String], date: Date)) async {
        let tmp = BootcampModel(id: UUID().uuidString,
                                name: values.info["name"] ?? "",
                                process: parseString(str: values.info["process"] ?? ""),
                                applyDeadline: Timestamp(date: values.date),
                                homepage: values.info["homepage"] ?? "",
                                period: values.info["period"] ?? "",
                                place: parseString(str: values.info["place"] ?? ""),
                                fee: values.info["fee"] ?? "",
                                organizer: values.info["organizer"] ?? "",
                                curriculum: values.info["curriculum"] ?? "",
                                selection: values.info["selection"] ?? "")
        
        _ = try? dbCollection.addDocument(from: tmp)
    }
    
    func parseString(str: String) -> [String] {
        str.components(separatedBy: "/")
    }
}

