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
    
    // information properties
    var movie: Movie?
    
    // backdrop image
    var backdropImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("MovieDetailsViewController called title = %@", movie?.title ?? "no value")
    }
}
