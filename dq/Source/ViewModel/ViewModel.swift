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



//(428.0, 845.0) 12promax
//(390.0, 763.0) 12pro
//same           12
//(375.0, 728.0) 12mini
