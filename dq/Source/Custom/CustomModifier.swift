//
//  customModifier.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/18.
//

import Foundation
import SwiftUI

struct PaddingFromSide: ViewModifier {
    @EnvironmentObject private var viewHandler: ViewHandler
    
    func body(content: Content) -> some View {
        if let tmpProxy = viewHandler.getGeoProxy() {
            return content
                .padding(.horizontal, tmpProxy.size.width / 15)
        } else {
            return content
                .padding(.horizontal, 20)
        }
    }
}

