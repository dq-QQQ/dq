//
//  UserNotificationModel.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/09/18.
//

import Foundation

struct UserNotificationModel {
    var id: String
    var name: String
    var expireDate: String
    var flag: Int
    
    func divideExpireDate() -> [Int] {
        var ret: [Int] = []
        var tmp = 3
        var i = 0
        
        while(i < expireDate.count) {
            ret.append(Int(expireDate.substring(from: i, to: i + tmp)) ?? 0)
            i += tmp + 1
            tmp = 1
        }
        return ret
    }
}
