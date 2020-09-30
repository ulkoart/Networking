//
//  AlamofireNetworkRequest.swift
//  Networking
//
//  Created by Alexey Efimov on 19.09.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireNetworkRequest {
    
    static func sendRequest(url: String, completion: @escaping (_ courses: [Course])->()) {
        
        guard let url = URL(string: url) else { return }
        
        
        request(url, method: .get).validate().responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                
                var courses = [Course]()
                courses = Course.getArray(from: value)!
                completion(courses)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func responseData(url: String) {
        request(url).responseData { (resposeData) in
            switch resposeData.result {
            case.success(let data):
                guard let string = String(data: data, encoding: .utf8) else { return }
                print(string)
            case.failure(let error):
                print(error)
            }
        }
    }
    
    static func responseString(url: String) {
        request(url).responseString { (responseString) in
            switch responseString.result {
            case.success(let string):
                print(string)
            case.failure(let error):
                print(error)
            }
        }
    }
    
    static func response(url: String) {
        request(url).response { (response) in
            guard
                let data = response.data,
                let string = String(data: data, encoding: .utf8) else { return }
            
            print(string)
            
        }
    }
    
    
}
