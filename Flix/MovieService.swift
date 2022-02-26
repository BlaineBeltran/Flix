//
//  MovieService.swift
//  Flix
//
//  Created by Blaine Beltran on 2/24/22.
//

import Foundation
import AlamofireImage

class MovieService {
    static let shared = MovieService()
    
    func getMovies(completion: @escaping ([Movie]) -> Void) {
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                 print(error.localizedDescription)
             } else if let data = data {
                 
                 let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 let movieData = dataDictionary["results"] as! [[String:Any]]
                 var movies = [Movie]()
                 for rawData in movieData {
                     var movie = Movie(title: rawData["title"] as! String,
                                       description: rawData["overview"] as! String,
                                       imageURL: ""
                     )
                     let baseURL = "https://image.tmdb.org/t/p/w185"
                     let posterPath = rawData["poster_path"] as! String
                     let posterURL = baseURL + posterPath
                     movie.imageURL = posterURL
                     movies.append(movie)
                 }
                 completion(movies)
             }
        }
        task.resume()
    }
}
