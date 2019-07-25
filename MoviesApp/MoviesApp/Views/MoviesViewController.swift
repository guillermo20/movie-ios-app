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

class MoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
 
    
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
    }
    
    // MARK: Collection delegate functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterViewCell.indentifier, for: indexPath) as! PosterViewCell
        cell.posterImageView.image = nil
        if indexPath.item != moviesList.count {
            NSLog("title = %@ ",  moviesList[indexPath.item].title ?? "novalue")
            if let data = moviesList[indexPath.item].posterImage {
                cell.posterImageView.image = UIImage(data: data)
            } else {
                presenter.fetchMovieImage(movie: moviesList[indexPath.item]) { (movie) in
                    if let imageData = movie?.posterImage {
                        cell.posterImageView.image = UIImage(data: imageData)
                    }
                }
            }
        } else {
            presenter.fetchMovies(moreData: true)
        }
        return cell
    }

}

// MARK: MVP view delegate functions
extension MoviesViewController: MoviesViewDelegate{
    
    func displayMovies(movies: [Movie]) {
//        moviesList = movies
        moviesList.append(contentsOf: movies)
        collectionView.reloadData()
    }
    
    func showError(message: String) {
        //todo:
    }
}

// MARK: extension with UICollectionViewDelegateFlowLayout
extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView
        , layout collectionViewLayout: UICollectionViewLayout
        , sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.collectionView.bounds.width/3.0
        let height = width*1.499 //calculated height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
