//
//  TimestampExtension.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/22.
//

import Foundation
import Firebase

extension Timestamp {
    func toDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        let date = Date(timeIntervalSince1970: TimeInterval(self.seconds))
        return dateFormatter.string(from: date)
    }
}
