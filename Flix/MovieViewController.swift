//
//  ViewController.swift
//  Flix
//
//  Created by Blaine Beltran on 2/24/22.
//

import UIKit


class MovieViewController: UIViewController {
    
    @IBOutlet weak var movieTableView: UITableView!
    private var movies = [Movie]() {
        didSet {
            // Everytime the movies var is pdated it will run line reloadData()
            movieTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.dataSource = self
        movieTableView.delegate = self
        movieTableView.rowHeight = UITableView.automaticDimension
        navigationController?.navigationBar.prefersLargeTitles = true
        MovieService.shared.getMoviesNowPlaying { [weak self] movies in
            
            guard let strongSelf = self else { return }
            strongSelf.movies = movies
        }
    }
}

// MARK: - Movie TableView Setup
extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieTableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Segue Setup
extension MovieViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetails" {
            let movieDetailVC = segue.destination as? MovieDetailViewController
            let cell = sender as! UITableViewCell
            let indexPath = movieTableView.indexPath(for: cell)!
            let movie = movies[indexPath.row]
            movieDetailVC?.movie = movie
            
            movieTableView.deselectRow(at: indexPath, animated: true)
        }
    }
}



