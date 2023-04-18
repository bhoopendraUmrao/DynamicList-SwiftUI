//
//  NetworkManager.swift
//  DynamicListSwiftUI
//
//  Created by Bhoopendra Umrao on 1/6/23.
//

import Foundation
import Combine

struct ApiUserResult: Decodable {
    let results: [ApiUser]
}

struct ApiUser: Decodable {
    let gender: String
    let name: UserName
    let email: String
    let phone: String
    let cell: String
    let picture: Picture
    var imageUrl: URL? {
        URL(string: picture.thumbnail)
    }
}

struct UserName: Decodable {
    let title: String
    let first: String
    let last: String
}

struct Picture: Decodable {
    let large: String
    let medium: String
    let thumbnail: String
}

final class NetworkManager: ObservableObject {
    
    func listUser() -> AnyPublisher<[ApiUser]?, Never> {
        guard let url = URL(string: "https://randomuser.me/api/") else {
            return Just(nil).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { data, response in
                do {
                    let decoder = JSONDecoder()
                    let userResponse = try decoder.decode(ApiUserResult.self, from: data)
                    return userResponse.results
                }
                catch {
                    return nil
                }
            }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
}
