//
//  ImageService.swift
//  MovieApp
//
//  Created by jaya kumar on 01/08/24.
//

import Foundation
import UIKit

class ImageService {
    static let shared = ImageService() 

    private init() {}
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Error: Could not convert data to image")
                completion(nil)
                return
            }
            
            completion(image)
        }
        task.resume()
    }
}
