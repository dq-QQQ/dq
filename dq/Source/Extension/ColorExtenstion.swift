//
//  File.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/15.
//

import SwiftUI

extension Color {
    static let dqGreen = Color(hex: "#07422D")
    static let dqGray = Color(hex: "#86868B")
    static let dqWhite = Color(hex: "#EAEBE2")
    
    //16진수로 RGB를 받는 이니셜라이저
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double((rgb >> 0) & 0xFF) / 255.0
        self.init(red:r, green:g, blue: b)
    }
}
