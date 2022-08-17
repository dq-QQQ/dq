//
//  customModifier.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/18.
//

import Foundation
import SwiftUI

struct PaddingFromSide: ViewModifier {
    func body(content: Content) -> some View {
        if let tmpProxy = ViewHandler.geoProxy {
            return content
                .padding(.horizontal, tmpProxy.size.width / 15)
        } else {
            return content
                .padding(.horizontal, 20)
        }
    }
}

