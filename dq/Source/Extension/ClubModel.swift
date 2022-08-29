//
//  ClubModel.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/22.
//

import Foundation
import Firebase

struct ClubModel : Identifiable, Codable {
    let id: String
    var logoURL: String = defaultURL
    var name: String
    let process: [String]
//    let isInterested: Bool
    var time: Timestamp
    
}
