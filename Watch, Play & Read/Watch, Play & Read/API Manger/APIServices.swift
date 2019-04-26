//
//  APIServices.swift
//  Watch, Play & Read
//
//  Created by Shreya Bhatia on 24/04/19.
//  Copyright © 2019 Shreya Bhatia. All rights reserved.
//

import Foundation

class APIServices {
    let baseURL: URL?
    
    init(baseAPI: String) {
        baseURL = URL(string: baseAPI)
    }
    
    func getAllObjects(completion: @escaping ([ObjectModel]?) -> Void) {
        if let objectURL = baseURL {
            let networkProcessor = NetworkProcessor(url: objectURL)
            networkProcessor.downloadJSONFromURL { (jsonDictionary) in
                if let objectDictionary = jsonDictionary?["feed"] as? [String : Any] {
                    if let finalArray = objectDictionary["results"] as? [[String : Any]] {
                        var objectArray = [ObjectModel]()
                        for object in finalArray {
                            let objectDetails = ObjectModel(objectDictionary: object)
                            objectArray.append(objectDetails)
                        }
                        completion(objectArray)
                    } else {
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }
        }
    }

}
