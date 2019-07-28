//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Guillermo Gutierrez on 7/25/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import UIKit
import MovieDBRepository
import MovieDataBase

class MovieDetailsViewController: UIViewController {
    
    // information property
    var movie: Movie?
    
    
    // UI related properties
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var avgVoteLabel: UILabel!
    @IBOutlet weak var backdropImageView: UIImageView!
    
    
    private let presenter = MovieDetailsPresenter(repository: DependencyInjector.dependencies.resolveRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("MovieDetailsViewController called title = %@", movie?.title ?? "no value")
        setupViews()
    }
    
    private func setupViews() {
        
        if let title = movie?.title {
            self.title = title
        }
        
        if let imageData = movie?.backdropImage {
            backdropImageView.image = UIImage(data: imageData)
        } else {
            if let movie = self.movie {
                presenter.fetchMovieBackdropImage(movie: movie) { movie in
                    if let movie = movie {
                        self.backdropImageView.image = UIImage(data: movie.backdropImage!)
                    }
                }
            }
        }
        
        if let releaseDate = movie?.releaseDate {
            releaseDateLabel.text = releaseDate.toString()
        }
        if let popularity = movie?.popularity {
            popularityLabel.text = String(format: "%.1f", popularity)
        }
        if let avgVote = movie?.voteAverage {
            avgVoteLabel.text = String(format: "%.1f", avgVote)
        }
    }
}
