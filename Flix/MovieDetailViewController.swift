//
//  MovieDetailViewController.swift
//  Flix
//
//  Created by Blaine Beltran on 3/1/22.
//

import UIKit
import AlamofireImage

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    
    @IBOutlet weak var detailSummaryLabel: UILabel!
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDetailVC(with: movie!)
    }
    
    func configureDetailVC(with movie: Movie) {
        
        detailTitleLabel.text = movie.title
        detailTitleLabel.sizeToFit()
        detailSummaryLabel.text = movie.description
        detailSummaryLabel.sizeToFit()
        movieImage.af.setImage(withURL: URL(string: movie.imageURL)!)
        backgroundView.af.setImage(withURL: URL(string: movie.backgroundImageURL)!)
        
    }

}
