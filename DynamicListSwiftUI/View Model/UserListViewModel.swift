//
//  UserListViewModel.swift
//  DynamicListSwiftUI
//
//  Created by Bhoopendra Umrao on 1/6/23.
//

import Foundation
import Combine

final class UserListViewModel: ObservableObject {
    
    @Published var userList: [ApiUser] = []
    
    private var cancelable = Set<AnyCancellable>()
    
    init() {
        getUserList()
    }
    
    func getUserList() {
        let network = NetworkManager()
        network.listUser()
            .receive(on: DispatchQueue.main)
            .sink { users in
                self.userList.insert(contentsOf: users ?? [], at: 0)
            }.store(in: &cancelable)
    }
}
