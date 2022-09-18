//
//  File.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/15.
//

import SwiftUI
import Firebase

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

extension Timestamp {
    func toDateString(flag: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        switch flag {
        case 0: dateFormatter.dateFormat = "MM월dd일 HH시mm분"
        case 1: dateFormatter.dateFormat = "YYYYMMddHHmm"
        default: break
        }
        
        let date = Date(timeIntervalSince1970: TimeInterval(self.seconds))
        return dateFormatter.string(from: date)
    }
}

 extension View {
    func tabItem(image: String, text:String) -> some View {
        self.tabItem {
            Image(systemName: image)
            Text(text)
        }
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


extension HorizontalAlignment {
    private enum CurrentAlignment : AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[HorizontalAlignment.center]
        }
    }
    static let horizontalAlignment = HorizontalAlignment(CurrentAlignment.self)
}


extension String {
    func substring(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else {
            return ""
        }
        
        let startIndex = index(self.startIndex, offsetBy: from)
        let endIndex = index(self.startIndex, offsetBy: to + 1)
        
        return String(self[startIndex ..< endIndex])
    }
}
