//
//  CustomType.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/20.
//

import Foundation

let defaultURL = "https://firebasestorage.googleapis.com/v0/b/dqapp-d00bb.appspot.com/o/empty.jpg?alt=media&token=82c55199-507b-41e5-9275-07e72bff42d4"

let realTimeDbURL = "https://dqapp-d00bb-default-rtdb.asia-southeast1.firebasedatabase.app"

enum Fields: String, CaseIterable {
    case All = "전체"
    case iOS = "iOS"
    case Android = "Android"
    case FrontEnd = "FrontEnd"
    case BackEnd = "BackEnd"
    case CS = "CS"
    case CrossPlatform = "CrossPlatform"
    case AI = "AI"
    case DataBase = "DataBase"
    case StartUP = "창업"
}

enum FieldsForDescription: String, CaseIterable {
    case iOS = "iOS"
    case Android = "Android"
    case CrossPlatform = "CrossPlatform"
    case FrontEnd = "FrontEnd"
    case BackEnd = "BackEnd"
    case GameClient = "Game Client"
    case GameServer = "Game Server"
    case Security = "Security"
    case DevOps = "DevOps"
    
    func getImageName() -> String {
        switch self {
        case .iOS, .Android, . CrossPlatform:
            return "iphone"
        case .FrontEnd:
            return "safari"
        case .BackEnd:
            return "server.rack"
        case .GameClient, .GameServer:
            return "gamecontroller"
        case .Security:
            return "shield.slash"
        case .DevOps:
            return "cloud"
        }
    }
    
    func getShortDescription() -> String {
        switch self {
        case .iOS: return "iOS 환경의 앱 개발자"
        case .Android: return "Android 환경의 앱 개발자"
        case .CrossPlatform: return "환경에 상관없는 앱 개발자"
        case .FrontEnd: return "클라이언트가 보는 것을 만드는 웹 개발자"
        case .BackEnd: return "클라이언트에게 안보이는 것을 만드는 개발자"
        case .GameClient: return "플레이어가 보는 것을 만드는 게임 개발자"
        case .GameServer: return "플레이어에게 안보이는 것을 만드는 게임 개발자"
        case .Security: return "외부 공격을 차단하는 보안 엔지니어"
        case .DevOps: return "개발 및 운영을 같이하는 전문가"
        }
    }
}

enum SwitchView: String {
    case main = "MainView"
    case info = "InfoView"
    case admin = "AdminView"
}

enum Tabs {
    case home, bootcamp, club
}

enum BootcampInformations: String, CaseIterable {
    case name = "이름"
    case process = "과정"
    case time = "지원 마감일"
    case fee = "비용"
    case place = "장소"
    case period = "기간"
    case organizer = "주관"
    case curriculum = "커리큘럼"
    case selection = "선발절차"
}


//enum FieldsValue: BootcampModel, CaseIterable {
//    typealias RawValue = <#type#>
//
//case name = self.name
//case process = self.process
//
//}
