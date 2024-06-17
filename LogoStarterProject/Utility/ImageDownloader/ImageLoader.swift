//
//  ImageLoader.swift
//  LogoStarterProject
//
//  Created by Raj Shekhar on 17/06/24.
//

import Foundation

final class ImageLoader {
    func loadImage(from urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 204, userInfo: nil)))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}
