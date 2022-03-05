//
//  MovieGridViewController.swift
//  Flix
//
//  Created by Blaine Beltran on 3/2/22.
//

import UIKit

class MovieGridViewController: UIViewController {

    @IBOutlet weak var movieCollectionView: UICollectionView!
    private var posterMovies = [Movie]() {
        didSet {
            // Everytime the movies var is udated it will run line reloadData()
            movieCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        navigationController?.navigationBar.prefersLargeTitles = true
        let layout = movieCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        layout.itemSize = CGSize(width: width, height: width * 1.5)
        MovieService.shared.getSuperHeroMovies { [weak self] posterMovies in
            
            guard let strongSelf = self else { return }
            strongSelf.posterMovies = posterMovies
        }
    }
    
}


// MARK: - Collection View Setup
extension MovieGridViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return posterMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as? MovieGridCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: posterMovies[indexPath.item])
        return cell
    }
}
