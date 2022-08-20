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

class ViewHandler : ObservableObject{
    let objectWillChange = PassthroughSubject<ViewHandler,Never>()
    var currentPage: String = SwitchView.main.rawValue {
        didSet{
            objectWillChange.send(self)
        }
    }
    @Published var currentTab: Tabs = .home
    static var geoProxy: GeometryProxy?
    
    func setGeoProxy(_ proxy: GeometryProxy) {
        ViewHandler.geoProxy = proxy
    }
    
    func getGeoProxy() -> GeometryProxy? { ViewHandler.geoProxy }
}


