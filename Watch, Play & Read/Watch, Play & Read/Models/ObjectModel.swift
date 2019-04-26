//
//  ObjectModel.swift
//  Watch, Play & Read
//
//  Created by Shreya Bhatia on 25/04/19.
//  Copyright © 2019 Shreya Bhatia. All rights reserved.
//

import UIKit

class ObjectModel {
    
    let id: String?
    let artistName: String?
    let releaseDate: String?
    let name: String?
    let kind: String?
    let copyright: String?
    let artistId: String?
    let artistUrl: String?
    let artworkImageUrl: String?
    let genres: [[String : Any]]?
    let url: String?
    var image: UIImage?
    
    struct ObjectKeys {
        static let id = "id"
        static let artistName = "artistName"
        static let kind = "kind"
        static let releaseDate = "releaseDate"
        static let artistId = "artistId"
        static let copyright = "copyright"
        static let name = "name"
        static let artistUrl = "artistUrl"
        static let artworkImageUrl = "artworkUrl100"
        static let genres = "genres"
        static let url = "url"
    }
    
    init(objectDictionary: [String: Any]) {
        id = objectDictionary[ObjectKeys.id] as? String
        name = objectDictionary[ObjectKeys.name] as? String
        kind = objectDictionary[ObjectKeys.kind] as? String
        artistName = objectDictionary[ObjectKeys.artistName] as? String
        copyright = objectDictionary[ObjectKeys.copyright] as? String
        releaseDate = objectDictionary[ObjectKeys.releaseDate] as? String
        artistId = objectDictionary[ObjectKeys.artistId] as? String
        artistUrl = objectDictionary[ObjectKeys.kind] as? String
        artworkImageUrl = objectDictionary[ObjectKeys.artworkImageUrl] as? String
        genres = objectDictionary[ObjectKeys.genres] as? [[String : Any]]
        url = objectDictionary[ObjectKeys.url] as? String
        let imageUrl = URL(string: (artworkImageUrl)!)
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageUrl!)  {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            } else {
                self.image = UIImage()
                
            }
        }
    }
    
}

