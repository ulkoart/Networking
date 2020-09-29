//
//  NetworkManager.swift
//  Networking
//
//  Created by user on 17/09/2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import UIKit

class NetworkManager {
    static func getRequest(url: String) {
        
        // "https://jsonplaceholder.typicode.com/posts"
        
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            guard let response = response, let data = data else { return }
            
            print(response)
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    static func postRequest(url: String) {
        
        // "https://jsonplaceholder.typicode.com/posts"
        
        guard let url = URL(string: url) else { return }
        
        let userData = ["Course": "Networking", "Lesson": "GET and POST"]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            guard let response = response, let data = data else { return }
            
            print(response)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        } .resume()
    }
    
    static func downloadImage(url: String, completion: @escaping (_ image: UIImage)->()) {
        
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        } .resume()
    }
    
    static func fetchData(url: String, complition: @escaping (_ courses:[Course])-> ()) {
        
        // let jsonUrlString = "https://swiftbook.ru/wp-content/uploads/api/api_course"
        // let jsonUrlString = "https://swiftbook.ru/wp-content/uploads/api/api_courses"
        // let jsonUrlString = "https://swiftbook.ru/wp-content/uploads/api/api_website_description"
        // let jsonUrlString = "https://swiftbook.ru/wp-content/uploads/api/api_missing_or_wrong_fields"
        
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let _ = response,
                let data = data
                else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let courses = try decoder.decode([Course].self, from: data)
                complition(courses)
            } catch let error{
                print("Error json - ", error.localizedDescription)
            }
            
        }.resume()
        
    }
    
    static func uploadImage(url: String) {
        let image = UIImage(named: "1455951514141525733")!
        let httpHeaders = ["Authorization": "Client-ID af151b1284173eb"]
        
        guard let imageProperties = ImageProperties(withImage: image, forKey: "image") else { return }
        
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = httpHeaders
        request.httpBody = imageProperties.data
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}
