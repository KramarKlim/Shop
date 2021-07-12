//
//  DataManager.swift
//  Shop
//
//  Created by Клим on 11.07.2021.
//

import UIKit

class DataManager {
    
    static let shared = DataManager()
    
    private init() {}
    
    let json = JSON()
    
    func configure(completion: @escaping (UIImage) -> Void) {
            for image in json.json {
                guard let url = URL(string: image) else { return }
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let error = error { print(error); return }
                    if let response = response { print(response)}
                    if let data = data, let image = UIImage(data: data) {
                        completion(image)
                    }
                }.resume()
            }
        }
    }
