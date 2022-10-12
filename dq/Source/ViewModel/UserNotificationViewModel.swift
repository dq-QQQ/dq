//
//  UserNotificationViewModel.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/09/18.
//

import SwiftUI
import UserNotifications

class UserNotificationViewModel: ObservableObject {
    @Published var models: [UserNotificationModel] = []
    var trigger: [[UNCalendarNotificationTrigger]] = [[]]
    var contents: [[UNMutableNotificationContent]] = [[]]
    
    
    func setDay( dateComponents: inout DateComponents, beforeDay: Int) {
        if dateComponents.day! >= beforeDay + 1 {
            dateComponents.day! -= beforeDay
        } else {
            let tmp = beforeDay - dateComponents.day!
            if dateComponents.month! == 3 {
                dateComponents.day! = 28 - tmp
            } else if dateComponents.month! / 2 == 0 {
                dateComponents.day! = 31 - tmp
            } else {
                dateComponents.day! = 30 - tmp
            }
            dateComponents.month! -= 1
        }
    }
    
    func setDateComponets(model: UserNotificationModel, flag: Int) -> DateComponents {
        var ret = DateComponents()
        let tmp = model.divideExpireDate()
        ret.year = tmp[0]
        ret.month = tmp[1]
        ret.day = tmp[2]
        ret.hour = tmp[3]
        ret.minute = tmp[4]
        
        switch flag {
        case 0:
            if ret.month == 1 {
                ret.year! -= 1
                ret.month! = 12
            } else {
                ret.month! -= 1
            }
            if ret.month! / 2 == 1 && ret.day! == 31 {
                ret.day! = 30
            }
        case 1: setDay(dateComponents: &ret, beforeDay: 7)
        case 2: setDay(dateComponents: &ret, beforeDay: 1)
        default: break
        }
        return ret
    }
    
    func triggerList(model: UserNotificationModel) -> [UNCalendarNotificationTrigger] {
        var ret: [UNCalendarNotificationTrigger] = []
        for i in 0..<3 {
            var tmp: DateComponents?
            switch i {
            case 0 : tmp = setDateComponets(model: model, flag: 0)
            case 1 : tmp = setDateComponets(model: model, flag: 1)
            case 2 : tmp = setDateComponets(model: model, flag: 2)
            default : break
            }
            ret.append(UNCalendarNotificationTrigger(dateMatching: tmp!, repeats: false))
        }
        return ret
    }
    
    func contentList(model: UserNotificationModel) -> [UNMutableNotificationContent] {
        var ret: [UNMutableNotificationContent] = []
        for i in 0..<3 {
            let content = UNMutableNotificationContent()
            
            switch i {
            case 0 : content.title = "\(String(describing: model.name))의 지원 마감날짜가 한달 남았어요!"
            case 1 : content.title = "\(String(describing: model.name))의 지원 마감날짜가 일주일 남았어요!"
            case 2 : content.title = "\(String(describing: model.name))의 지원 마감날짜가 하루 남았어요!"
            default : break
            }
            content.body = "관심있는 부트캠프. dq에서 확인해보세요!"
            content.sound = UNNotificationSound.default
            ret.append(content)
        }
        return ret
    }
    
    func getAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func addNotification(id: String, name: String, expireDate: String, flag: Int) {
        let model = UserNotificationModel(id: id, name: name, expireDate: expireDate, flag: flag)
        let content = contentList(model: model)
        let trigger = triggerList(model: model)
        models.append(model)
        for i in 0..<3 {
            let request = UNNotificationRequest(identifier: model.id + String(i),
                                                content: content[i],
                                                trigger: trigger[i])
            UNUserNotificationCenter.current().add(request)
        }
    }
    
    func removeNotification(id: String) {
        var removeIdentifiers: [String] = []
        for i in 0..<3 {
            removeIdentifiers.append(id + String(i))
        }
        for i in 0..<models.count {
            if models[i].id == id {
                models.remove(at: i)
                break
            }
        }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: removeIdentifiers)
    }
    
    func resetNotification(id: String, name: String, expireDate: String, flag: Int) {
        removeNotification(id: id)
        addNotification(id: id, name: name, expireDate: expireDate, flag: flag)
    }
}
