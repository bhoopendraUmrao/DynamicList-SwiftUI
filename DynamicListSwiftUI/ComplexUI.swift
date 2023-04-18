//
//  ComplexUI.swift
//  DynamicListSwiftUI
//
//  Created by Bhoopendra Umrao on 1/5/23.
//

import SwiftUI

struct Post: Identifiable {
    let id: String
    let title: String
    let subTitle: String
    let description: String
    let profileImage: URL?
    let postImage: String
}



struct ComplexUI: View {
    
    let imageArray = ["11", "22", "33", "44"]
    let desc = "Yes, there are a lot of Lorem Ipsum generators already. Even when we started with this one in 2009. But all others lack features, or are too limited."
    let postedArray = ["Posted 8 hours ago",
                       "Posted 7 hours ago",
                       "Posted 3 hours ago",
                       "Posted 1 hours ago"]
    
    let users: [ApiUser]
    var body: some View {
        VStack {
            List {
                VStack(alignment: .leading) {
                    Text("Users").font(.headline)
                    ScrollView(.horizontal) {
                        HStack(alignment: .top) {
                            ForEach(users,id: \.email) { user in
                                UserHorizontalView(user: user)
                                    .clipped()
                            }
                        }
                    }
                }
                ForEach(users, id: \.email) { user in
                    let post = Post(id: UUID().uuidString, title: user.name.first, subTitle: postedArray.randomElement() ?? "NA", description: desc, profileImage: user.imageUrl, postImage: imageArray.randomElement() ?? "22")
                    PostView(post: post)
                }
            }
        }
    }
}

struct PostView: View {
    let post: Post
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                AsyncImage(url: post.profileImage) { image in
                    image
                        .resizable()
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                } placeholder: {
                    Image(systemName: "person")
                        .frame(width: 60, height: 60)
                        .background(Color(UIColor.lightGray))
                        .clipShape(Circle())
                        .overlay(Circle().stroke())
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text(post.title).font(.headline)
                    Text(post.subTitle).font(.subheadline)
                }
            }.padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 8))
            Text(post.description)
            Image(post.postImage)
                .resizable()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200)
                .padding(EdgeInsets(top: 0, leading: -20, bottom: 0, trailing: -20))
        }
    }
}

struct UserHorizontalView: View {
    let user: ApiUser
    var body: some View {
        VStack {
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
            Text(user.name.first)
        }
    }
}

struct ComplexUI_Previews: PreviewProvider {
    static var previews: some View {
        ComplexUI(users: [])
    }
}
