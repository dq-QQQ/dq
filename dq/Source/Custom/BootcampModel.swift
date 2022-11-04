//
//  BootcampModel.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/18.
//

import Foundation
import FirebaseFirestore
import SwiftUI

struct BootcampModel : Identifiable, Codable {
    let id: String
    var logoURL: String = defaultURL
    var name: String
    let process: [String]
    var applyDeadline: Timestamp
    let homepage: String
    let period : String
    let place: [String]
    let fee: String
    let organizer: String
    let curriculum: String
    let selection: String
}
