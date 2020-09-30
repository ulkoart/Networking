//
//  NetworkManager.swift
//  urlRequestWithProgress
//
//  Created by user on 30.09.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//

import UIKit

protocol NetworkManager {
    typealias downloadRandomBigImageCompletion = (UIImage?) -> Void
    static var onProgress: ((Double) -> ())? { get set }

    static func downloadRandomBigImage(
        completion: @escaping downloadRandomBigImageCompletion
    )
}

final class NetworkManagerImp: NetworkManager {
    
    private static let url: String = "https://source.unsplash.com/random/40000x40000"
    private static var observation: NSKeyValueObservation?
    
    static var onProgress: ((Double) -> ())?
    
    static func downloadRandomBigImage(completion: @escaping downloadRandomBigImageCompletion) {
        guard let url = URL(string: self.url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                completion(nil)
                return
            }
            guard let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }
        
        observation = task.progress.observe(\.fractionCompleted) { progress, _ in
            let progress = progress.fractionCompleted
            self.onProgress?(progress)
        }
        
        task.resume()
    }
}
