//
//  Imge.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 27.03.24.
//

import UIKit

final class ImageLoaderService {
    static let shared = ImageLoaderService()

    private init() {}

    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
