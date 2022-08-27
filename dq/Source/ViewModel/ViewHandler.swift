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
    
    private var geoProxy: GeometryProxy?
    func setGeoProxy(_ proxy: GeometryProxy) { geoProxy = proxy }
    func getGeoProxy() -> GeometryProxy? { geoProxy }
    
    
}

class ViewHandler2 {
    let objectWillChange = PassthroughSubject<ViewHandler2,Never>()
    var currentPage: String = Fields.All.rawValue {
        didSet{
            objectWillChange.send(self)
        }
    }
}

//(428.0, 845.0) 12promax
//(390.0, 763.0) 12pro
//same           12
//(375.0, 728.0) 12mini
