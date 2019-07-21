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

class MoviesViewController: UIViewController, UICollectionViewDelegate
, UICollectionViewDataSource , MoviesViewDelegate {
 
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var moviesList = [Movie]()
    
    // repository should be injected with a dependency injector.
    private let presenter = MoviesPresenter(repository: DependencyInjector.dependencies.resolveRepository())
    
    // MARK: UIViewController functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.setViewDelegate(viewDelegate: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpCollectionView()
        self.presenter.fetchMovies()
    }
    
    func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.register(UINib(nibName: PosterViewCell.indentifier, bundle: nil)
//            , forCellWithReuseIdentifier: PosterViewCell.indentifier)
//        let layout = UICollectionViewFlowLayout()
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        layout.scrollDirection = .vertical

    }
    
    // MARK: Collection delegate functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterViewCell.indentifier, for: indexPath) as! PosterViewCell
        if let data = moviesList[indexPath.item].posterImage {
            cell.posterImageView.image = UIImage(data: data)
        }
        return cell
    }
    
    // MARK: MVP view delegate functions
    func displayMovies(movies: [Movie]) {
        moviesList = movies
        presenter.fetchMovieImage(movie: movies[0])
        collectionView.reloadData()
    }
    
    func updateMovieImage(data: Data) {
        moviesList[0].posterImage = data
        collectionView.reloadData()
    }
    
    func showError(message: String) {
        //todo:
    }
    
}
