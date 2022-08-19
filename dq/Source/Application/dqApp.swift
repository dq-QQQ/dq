//
//  dqApp.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/15.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
      return true
  }
}

@main
struct dqApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    init() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.init(name: AppFontName.mainfont, size: 12)! ], for: .normal) // 탭바 마비노기로 바꾸기
    }
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(BootcampViewModel())
        }
    }
}
