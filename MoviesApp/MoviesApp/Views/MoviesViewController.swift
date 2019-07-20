//
//  MoviesViewController.swift
//  MoviesApp
//
//  Created by Guillermo Gutierrez on 7/18/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import UIKit
import MovieDBRepository
import MovieDataBase

class MoviesViewController: UIViewController, MoviesViewDelegate {
    
    
    // repository should be injected with a dependency injector.
    private let presenter = MoviesPresenter(repository: DependencyInjector.dependencies.resolveRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.presenter.setViewDelegate(viewDelegate: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.presenter.fetchMovies()
    }
    
    func displayMovies(movies: [Movie]) {
        //todo:
    }
    
    func showError(message: String) {
        //todo:
    }
    
}
