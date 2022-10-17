//
//  ToastViewModel.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/10/10.
//

import Foundation


class ToastViewModel : ObservableObject {
    @Published var showTopToast = false
    @Published var flag = false
    
    func toggleData(flag: Bool) {
        showTopToast = true
        self.flag = flag
    }
}
