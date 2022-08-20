//
//  BootcampModalView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/17.
//

import SwiftUI

struct BootcampModalView: View {
    @Binding var bootcampList: [BootcampModel]
    @EnvironmentObject private var viewHandler: ViewHandler
    
    var body: some View {
        Text(viewHandler.selection ?? "ho")
    }
}
//
//struct BootcampModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        BootcampModalView()
//    }
//}
