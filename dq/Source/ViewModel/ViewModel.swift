//
//  ViewModel.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/17.
//

import SwiftUI

class ViewModel: ObservableObject {
    private var geoProxy: GeometryProxy?

    func setGeoProxy(_ proxy: GeometryProxy) {
        geoProxy = proxy
    }
    
    func getGeoProxy() -> GeometryProxy? { geoProxy }
}
