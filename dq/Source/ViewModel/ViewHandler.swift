//
//  ViewRouter.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/17.
//

import Combine
import SwiftUI

class ViewHandler : ObservableObject{
    let objectWillChange = PassthroughSubject<ViewHandler,Never>()
    var currentPage: String = SwitchView.main.rawValue {
        didSet{
            objectWillChange.send(self)
        }
    }
    @Published var currentTab: Tabs = .home
    @Published var selection: String?
    var currentTabsss: Tabs! {
        didSet{
            objectWillChange.send(self)
        }
    }
    
    var geoProxy: GeometryProxy?
    
    func setGeoProxy(_ proxy: GeometryProxy) {
        geoProxy = proxy
    }
    
    func getGeoProxy() -> GeometryProxy? { geoProxy }
}


