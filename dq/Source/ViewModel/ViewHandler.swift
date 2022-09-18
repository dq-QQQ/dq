//
//  ViewHandler.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/09/18.
//

import Combine

class MainViewHandler : ObservableObject {
    let objectWillChange = PassthroughSubject<MainViewHandler,Never>()
    var currentPage: String = SwitchView.main.rawValue {
        didSet{
            objectWillChange.send(self)
        }
    }
}

class FieldsViewHandler: ObservableObject {
    let objectWillChange = PassthroughSubject<FieldsViewHandler,Never>()
    var currentPage: String = Fields.All.rawValue {
        didSet{
            objectWillChange.send(self)
        }
    }
}
