//
//  AddUser.swift
//  DynamicListSwiftUI
//
//  Created by Bhoopendra Umrao on 1/5/23.
//

import SwiftUI


struct AddUser: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var userArray: [User] = []
    var body: some View {
        VStack {
            HStack {
                Text("First name: ").font(.subheadline)
                Text(firstName)
                    .font(.subheadline)
                    .foregroundColor(.red)
                Spacer()
            }.padding(.leading, 16)
            
            HStack {
                Text("Last name: ").font(.subheadline)
                Text(lastName)
                    .font(.subheadline)
                    .foregroundColor(.red)
                Spacer()
            }.padding(.leading, 16)
            
            AddUserView(firstName: $firstName, lastName: $lastName, userArray: $userArray)
            
            VStack(alignment: .leading) {
                Text("User List").font(.headline)
                    .padding()
                List(userArray, id: \.name) {
                    Text($0.name)
                }
                .background(.white)
            }
        }
    }
}

struct AddUserView: View {
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var userArray: [User]
    var body: some View {
        VStack {
            Group {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
            }
            .padding()
            .border(.gray, width: 2)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            
            Button {
                userArray.append(User(id: 0, name: firstName, bio: lastName, image: "11"))
                firstName = ""
                lastName = ""
            } label: {
                Text("Create User")
                    .padding()
                    .foregroundColor(.white)
            }
            .background(.primary)
            .shadow(radius: 8)
            .padding()
        }
        .padding([.leading, .trailing], 16)
    }
}

struct AddUser_Previews: PreviewProvider {
    static var previews: some View {
        AddUser()
    }
}
