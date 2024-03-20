//
//  ShopApiManager.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 19.03.24.
//

import Foundation

class ShopApiManager {
    static let shared = ShopApiManager()

    func performRequest<T: Decodable>(for endpoint: ShopApiEndpoint, completion: @escaping (Result<T?, Error>) -> Void) {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = endpoint.httpMethod
        request.httpBody = endpoint.httpBody

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                        completion(.success(nil))
                    } else {
                        completion(.failure(error))
                    }
                }
            } else {
                completion(.failure(NSError(domain: "com.thetestshop.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unexpected response from server"])))
            }
        }
        task.resume()
    }
}
