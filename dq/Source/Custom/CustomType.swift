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

enum fields: String, CaseIterable {
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
