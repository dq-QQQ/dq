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
    @State var ho : BootcampModel
    
    
    var body: some View {

        Text(ho.name)
            .onAppear {
                ho = bootcampList.filter { $0.id == viewHandler.selection}[0]
                print(ho.time.toDateString())
            }
            
        
    }
}
//
//struct BootcampModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        BootcampModalView()
//    }
//}
