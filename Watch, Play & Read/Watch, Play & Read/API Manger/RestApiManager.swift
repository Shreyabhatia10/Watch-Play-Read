//
//  RestApiManager.swift
//  Watch, Play & Read
//
//  Created by Shreya Bhatia on 24/04/19.
//  Copyright © 2019 Shreya Bhatia. All rights reserved.
//

import Foundation

final class RestApiManager: NSObject {
    
    static let sharedInstance = RestApiManager()
    
    let jsonQueue = DispatchQueue(label: "jsonQueue")
    
    let musicURL = "https://rss.itunes.apple.com/api/v1/in/apple-music/hot-tracks/all/10/explicit.json"
    let bookURL = "https://rss.itunes.apple.com/api/v1/in/books/top-free/all/10/explicit.json";
    let tvSeriesURL = "https://rss.itunes.apple.com/api/v1/us/tv-shows/top-tv-episodes/all/10/explicit.json";
    let moviesURL = "https://rss.itunes.apple.com/api/v1/in/movies/top-movies/all/10/explicit.json";
    
    static var musicArray = [ObjectModel]()
    static var bookArray = [ObjectModel]()
    static var tvSeriesArray = [ObjectModel]()
    static var movieArray = [ObjectModel]()
    
    var delegate: ActivityIndicatorProtocol?

    private override init() {
        // implement init here
    }
    
    func loadAllData() {
        self.loadAllMusicData()
        self.loadAllBooksData()
        self.loadAllMovieArray()
        self.loadAllTvSeriesData()
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
            self.delegate?.stopLoading()
        })
    }
    
    private func loadAllMusicData() {
        let apiService = APIServices(baseAPI: self.musicURL)
        apiService.getAllObjects { (music) in
            RestApiManager.musicArray = music ?? []
        }
    }
    
    private func loadAllBooksData() {
        let apiService = APIServices(baseAPI: self.bookURL)
        apiService.getAllObjects { (book) in
            RestApiManager.bookArray = book ?? []
        }
    }
    
    private func loadAllMovieArray() {
        let apiService = APIServices(baseAPI: self.tvSeriesURL)
        apiService.getAllObjects { (tvSeries) in
            RestApiManager.tvSeriesArray = tvSeries ?? []
        }
    }
    
    private func loadAllTvSeriesData() {
        let apiService = APIServices(baseAPI: self.moviesURL)
        apiService.getAllObjects { (movies) in
            RestApiManager.movieArray = movies ?? []
        }
    }
}

