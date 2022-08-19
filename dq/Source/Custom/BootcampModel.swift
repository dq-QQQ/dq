//
//  BootcampModel.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/18.
//

import Foundation


struct BootcampModel : Identifiable, Codable {
    let id: String
    var logoURL: String = "https://firebasestorage.googleapis.com/v0/b/dqapp-d00bb.appspot.com/o/empty.jpg?alt=media&token=82c55199-507b-41e5-9275-07e72bff42d4"
    var name: String
    let process: String
    let isInterested: Bool
    
    
}
