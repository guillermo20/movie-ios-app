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
        return moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterViewCell.indentifier, for: indexPath) as! PosterViewCell
        //tags a cell so the images are loaded to the correspondent cell
        cell.tag = indexPath.item
        cell.posterImageView.image = nil
        NSLog("title = %@ ",  moviesList[indexPath.item].title ?? "novalue")
        if let data = moviesList[indexPath.item].posterImage {
            cell.posterImageView.image = UIImage(data: data)
        } else {
            presenter.fetchMovieImage(movie: moviesList[indexPath.item]) { (movie) in
                if let imageData = movie?.posterImage {
                    // validates that image is going to be set to the correct cell
                    if cell.tag == indexPath.item {
                        cell.posterImageView.image = UIImage(data: imageData)
                    }
                }
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == moviesList.count - 1 {
            // request more data as the user scrolls down
            presenter.fetchMovies(moreData: true)
        }
    }
    
    // navigation implementation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPath(for: cell) {
            let controller = segue.destination as! MovieDetailsViewController
            controller.movie = moviesList[indexPath.item]
        }
    }
}

// MARK: MVP view delegate functions
extension MoviesViewController: MoviesViewDelegate{
    
    func displayMovies(movies: [Movie]) {
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
        // calculates width and height so the are 3 colums per row.
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
