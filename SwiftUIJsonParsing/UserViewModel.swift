//
//  RestAPIManager.swift
//  SwiftUIJsonParsing
//
//  Created by Yugandhar Kommineni on 11/12/21.
//

import SwiftUI

class UserViewModel: ObservableObject {
    @Published var fetchUsers: [UserModel]?
    
    init() {
        fetchUserData()
    }
    
    func fetchUserData() {
        guard let userUrl = URL(string: "https://jsonplaceholder.typicode.com/users") else { return  }
        URLSession.shared.dataTask(with: userUrl) { (data, response, error) in
            
            guard let jsonData = data else {return}
            guard let jsonArray = try? JSONDecoder().decode(Welcome.self, from: jsonData) else {return}
            print(jsonArray)

            DispatchQueue.main.async {[weak self] in
                self?.fetchUsers = jsonArray
                print(jsonArray)
            }
        }.resume()
    }
}
