//
//  BootcampModel.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/18.
//

import Foundation
import Firebase
import SwiftUI

struct BootcampModel : Identifiable, Codable {
    let id: String
    var logoURL: String = defaultURL
    var name: String
    let process: [String]
    var applyDeadline: Timestamp
    var homepage: String
    var period : String
    var place: [String]
    var fee: String
    var organizer: String
}
