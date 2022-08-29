//
//  ViewRouter.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/17.
//

import Combine
import SwiftUI

class ViewModel : ObservableObject {
    @Published var currentTab: Tabs = .home
    @Published var selection: String?
    
//    @Published var bootcampList: [[BootcampModel]] = [[]]
//    var bootcamp = BootcampViewModel("BootCamp")
    
    private var geoProxy: GeometryProxy?
    func setGeoProxy(_ proxy: GeometryProxy) { geoProxy = proxy }
    func getPhoneSize() -> CGSize {
        if let proxy = geoProxy {
            return proxy.size
        } else {
            return CGSize(width: 800.0, height: 400.0)
        }
    }
}

class MainViewHandler : ObservableObject {
    let objectWillChange = PassthroughSubject<MainViewHandler,Never>()
    var currentPage: String = SwitchView.main.rawValue {
        didSet{
            objectWillChange.send(self)
        }
    }
}

class VH2 {
    let objectWillChange = PassthroughSubject<VH2,Never>()
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
