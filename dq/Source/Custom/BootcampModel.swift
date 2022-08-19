//
//  BootcampModel.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/18.
//

import Foundation


struct BootcampModel : Identifiable, Codable {
    let id: String
    let logoURL: String?
    let name: String
    let process: String
    let isInterested: Bool
    
    
}
