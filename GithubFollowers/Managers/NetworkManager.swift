//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Oscar Cristaldo on 2022-07-23.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    static let baseURL = "https://api.github.com"
    static let usersURL = baseURL + "/users"
    
    func getFollowers(for username: String, page: Int, per_page: Int = 100, completed: @escaping ([Follower]?, GFErrorMessage?) -> Void) {
        let endpoint = NetworkManager.usersURL + "/\(username)/followers?per_page=\(per_page)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(nil, .invalidUsername)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil, .unableToComplete)
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else  {
                completed(nil, .invalidResponse)
                return
            }
            
            guard let data = data else {
                completed(nil, .invalidData)
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            } catch {
                completed(nil, .invalidData)
            }
        }
        
        task.resume()
    }
}
