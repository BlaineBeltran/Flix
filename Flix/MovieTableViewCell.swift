//
//  MovieTableViewCell.swift
//  Flix
//
//  Created by Blaine Beltran on 2/24/22.
//

import UIKit
import AlamofireImage

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageLabel: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    

    func configure(with movie: Movie) {
        
        movieTitleLabel.text = movie.title
        movieDescriptionLabel.text = movie.description
        movieImageLabel.af.setImage(withURL: URL(string: movie.imageURL)!)
    }
    
}
