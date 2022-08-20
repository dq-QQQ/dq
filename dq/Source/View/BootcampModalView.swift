//
//  BootcampModalView.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/08/17.
//

import SwiftUI

struct BootcampModalView: View {
    @Binding var bootcampList: [BootcampModel]
    @Binding var bootcampID: String?
    
    var body: some View {
        Text(bootcampID ?? "ho")
    }
}
//
//struct BootcampModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        BootcampModalView()
//    }
//}
