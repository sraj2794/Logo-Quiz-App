//
//  LogoLoader.swift
//  LogoStarterProject
//
//  Created by Raj Shekhar on 17/06/24.
//

import Foundation




final class LogoLoader {
    func loadLogos(completion: @escaping (Result<[Logo], Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "logo", withExtension: "txt") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 404, userInfo: nil)))
            return
        }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let logos = try JSONDecoder().decode([Logo].self, from: data)
                completion(.success(logos))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
