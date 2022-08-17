//
//  ViewRouter.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/17.
//

import Combine
import SwiftUI


enum SwitchView: String {
    case main = "MainView", info = "InfoView"
}

enum ho {
    case ho, ho2
}

enum Tabs {
    case home, bootcamp, club
}

class ViewRouter : ObservableObject{
    @Published var currentTab: Tabs = .home
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    
    var currentPage: String = SwitchView.main.rawValue {
        didSet{
            objectWillChange.send(self)
        }
    }
}


