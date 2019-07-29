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
    
    @IBOutlet weak var overviewTextView: UITextView!
    
    private let presenter = MovieDetailsPresenter(repository: DependencyInjector.dependencies.resolveRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("MovieDetailsViewController called title = %@", movie?.title ?? "no value")
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
        if let overview = movie?.overview {
            overviewTextView.text = overview
        }
    }
}
