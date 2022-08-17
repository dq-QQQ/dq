//
//  dqApp.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/15.
//

import SwiftUI

@main
struct dqApp: App {
    init() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.init(name: AppFontName.mainfont, size: 12)! ], for: .normal) // 탭바 마비노기로 바꾸기
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
