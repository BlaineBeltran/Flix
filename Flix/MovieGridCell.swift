//
//  MovieGridCell.swift
//  Flix
//
//  Created by Blaine Beltran on 3/4/22.
//

import UIKit
import AlamofireImage

class MovieGridCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    func configure(with movie: Movie) {
        
        posterImageView.af.setImage(withURL: URL(string: movie.imageURL)!)
    }
}
