//
//  NetworkProcessor.swift
//  Watch, Play & Read
//
//  Created by Shreya Bhatia on 24/04/19.
//  Copyright © 2019 Shreya Bhatia. All rights reserved.
//

import Foundation

class NetworkProcessor {
    
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    typealias JSONDictionaryHandler = (([String: Any]?) -> Void)
    
    func downloadJSONFromURL(_ completion: @escaping JSONDictionaryHandler) {

        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            do {
                let jsonDictionary = try JSONSerialization.jsonObject(with: dataResponse, options: .mutableContainers)
                completion(jsonDictionary as? [String: Any])
            } catch let error as NSError {
                print("Error while processing json data: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
}

