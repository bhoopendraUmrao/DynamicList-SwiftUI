//
//  ContentView.swift
//  DynamicListSwiftUI
//
//  Created by Bhoopendra Umrao on 1/5/23.
//

import SwiftUI

struct User: Identifiable {
    var id: Int
    let name: String
    let bio: String
    let image: String
}

struct ContentView: View {
    @StateObject private var userListViewModel = UserListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Text("Users").font(.title)
                ForEach(userListViewModel.userList, id: \.name.first) { user in
                    NavigationLink() {
                        ComplexUI(users: userListViewModel.userList)
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarTitle(Text("Posts"))
                    } label: {
                        UserView(user: user)
                    }
                }
                .onDelete { indexes in
                    userListViewModel.userList.remove(at: indexes.first ?? 0)
                }
            }
            .navigationTitle(Text("Dynamic List"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink() {
                        AddUser()
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarTitle(Text("Create user"))
                    } label: {
                        Text("Add")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        userListViewModel.getUserList()
                    } label: {
                        Text("Refresh")
                    }
                }
            }
        }
    }
}

struct UserView: View {
    let user: ApiUser
    var body: some View {
        HStack(spacing: 18) {
            AsyncImage(url: user.imageUrl) { image in
                image
                    .resizable()
                    .frame(width: 60, height: 60)
                    .background(Color(UIColor.lightGray))
                    .clipShape(Circle())
                    .overlay(Circle().stroke())
            } placeholder: {
                Image(systemName: "person")
                    .frame(width: 60, height: 60)
                    .background(Color(UIColor.lightGray))
                    .clipShape(Circle())
                    .overlay(Circle().stroke())
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text(user.name.first).font(.headline)
                Text(user.name.last).font(.subheadline)
            }
        }.listRowSeparator(.automatic)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
