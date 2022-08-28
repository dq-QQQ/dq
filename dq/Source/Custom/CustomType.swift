//
//  CustomType.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/20.
//

import Foundation

enum logosURLs : String {
    case defaultURL = "https://firebasestorage.googleapis.com/v0/b/dqapp-d00bb.appspot.com/o/empty.jpg?alt=media&token=82c55199-507b-41e5-9275-07e72bff42d4"
}

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


enum SwitchView: String {
    case main = "MainView"
    case info = "InfoView"
}

enum Tabs {
    case home, bootcamp, club
}



enum FieldsInfo: String, CaseIterable {
    case name = "이름"
    case process = "과정"
    case time = "지원 마감일"
    case homepage = "홈페이지"
    case fee = "비용"
    case place = "장소"
    case period = "기간"
    case organizer = "주관"
}


//enum FieldsValue: BootcampModel, CaseIterable {
//    typealias RawValue = <#type#>
//
//case name = self.name
//case process = self.process
//
//}
